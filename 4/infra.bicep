param webAppName string = 'cadulldemo'
param planName string = 'cadulldemo-plan'

resource planName_resource 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: planName
  location: resourceGroup().location
  sku: {
    name: 'F1'
    capacity: 1
  }
  properties: {}
}

resource webAppName_resource 'Microsoft.Web/sites@2020-12-01' = {
  name: webAppName
  location: resourceGroup().location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/${planName}': 'Resource'
    displayName: webAppName
  }
  properties: {
    serverFarmId: planName_resource.id
  }
}