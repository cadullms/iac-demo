param webAppName string
param planName string
param keyVaultName string
param sqlServerName string
@secure()
param sqlAdminPassword string 
param sqlAdminUsername string = 'azureuser'

resource plan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: planName
  location: resourceGroup().location
  sku: {
    name: 'F1'
    capacity: 1
  }
  properties: {}
}

resource webApp 'Microsoft.Web/sites@2020-12-01' = {
  name: webAppName
  location: resourceGroup().location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/${planName}': 'Resource'
    displayName: webAppName
  }
  properties: {
    serverFarmId: plan.id
    keyVaultReferenceIdentity: appIdentity.id
  }

  resource settings 'config' = {
    name: 'appsettings'
    properties: {
      connectionString: '@Microsoft.KeyVault(SecretUri=${keyVault::connectionStringSecret.properties.secretUri})'
    }
  }

  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${appIdentity.id}': {}
    }
  }
}

resource appIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2018-11-30' = {
  name: 'app-identity'
  location: resourceGroup().location
}

resource sqlServer 'Microsoft.Sql/servers@2021-05-01-preview' = {
  name: sqlServerName
  location: resourceGroup().location
  properties: {
    administratorLogin: sqlAdminUsername
    administratorLoginPassword: sqlAdminPassword
  }

  resource allowAllAzureIps 'firewallRules@2021-05-01-preview' = {
    name: 'string'
    properties: {
      endIpAddress: '0.0.0.0'
      startIpAddress: '0.0.0.0'
    }
  }
  
}

var connectionString = 'Server=tcp:${sqlServer.name}${environment().suffixes.sqlServerHostname},1433;Initial Catalog=master;Persist Security Info=False;User ID=${sqlAdminUsername};Password=${sqlAdminPassword};MultipleActiveResultSets=False;'

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: keyVaultName
  location: resourceGroup().location
  properties: {
    tenantId: subscription().tenantId
    accessPolicies: [
      {
        tenantId: subscription().tenantId
        objectId: appIdentity.properties.principalId
        permissions: {
          secrets: [
            'list'
            'get'
          ]
        }
      }
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }

  resource connectionStringSecret 'secrets' = {
    name: 'connectionString'
    properties: {
      value: connectionString
    }
  }
}
