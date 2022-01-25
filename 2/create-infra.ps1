param
(
    $namePrefix = "cadulldemo2",
    $location = "westeurope",
    $resourceGroupName = "$namePrefix-rg",
    $planName = "$namePrefix-plan",
    $webAppName = "$namePrefix"
)

az group create -n $resourceGroupName -l $location --tags "purpose=demo"
$timeStamp = [DateTime]::Now.Ticks
az deployment group create -g $resourceGroupName -n "deployment-$timeStamp" --template-file $PSScriptRoot/infra.json --mode Complete --parameters webAppName=$webAppName planName=$planName
