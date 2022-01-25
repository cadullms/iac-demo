param
(
    $namePrefix = "cadulldemo5",
    $environmentLabel = "n/a",
    $location = "westeurope",
    $resourceGroupName = "$namePrefix-rg",
    $planName = "$namePrefix-plan",
    $webAppName = "$namePrefix",
    $sqlServerName = "$namePrefix-db",
    $keyVaultName = "$namePrefix-kv"
)

az group create -n $resourceGroupName -l $location --tags "purpose=demo"
$timeStamp = [DateTime]::Now.Ticks
az deployment group create -g $resourceGroupName -n "deployment-$timeStamp" --template-file $PSScriptRoot/infra.bicep --mode Complete --parameters webAppName=$webAppName planName=$planName sqlAdminPassword=P2ssw0rd sqlServerName=$sqlServerName keyVaultName=$keyVaultName environmentLabel=$environmentLabel
