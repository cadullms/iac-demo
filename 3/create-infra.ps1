param
(
    $namePrefix = "cadulldemo3",
    $location = "westeurope",
    $resourceGroupName = "$namePrefix-rg",
    $planName = "$namePrefix-plan",
    $webAppName = "$namePrefix",
    $terraformPath = $PSScriptRoot
)

Push-Location
Set-Location $terraformPath

terraform init
# terraform plan -var namePrefix=$namePrefix
terraform apply -auto-approve -var namePrefix=$namePrefix

Pop-Location