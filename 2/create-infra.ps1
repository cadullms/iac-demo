param
(
    $namePrefix = "cadulldemo2a",
    $location = "westeurope",
    $resourceGroupName = "$namePrefix-rg",
    $planName = "$namePrefix-plan",
    $webAppName = "$namePrefix-2"
)

az group create -n $resourceGroupName -l $location --tags "purpose=demo"DateTime
$timeStamp = [DateTime]::Now.Ticks
az deployment group create -g $resourceGroupName -n "deployment-$timeStamp" --template-file $PSScriptRoot/infra.json --mode Complete --parameters webAppName=$webAppName planName=$planName