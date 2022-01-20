param
(
    $namePrefix = "cadulldemo",
    $location = "westeurope",
    $resourceGroupName = "$namePrefix-rg",
    $planName = "$namePrefix-plan",
    $webAppName = "$namePrefix"
)

az group create -n $resourceGroupName -l $location --tags "purpose=demo"
az appservice plan create -n $planName -g $resourceGroupName
$webAppId = (az webapp create -n $webAppName -p $planName -g $resourceGroupName --query "id")
Write-Host "We created web app with id $webAppId"