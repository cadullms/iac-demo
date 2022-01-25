resource "azurerm_resource_group" "group" {
  name     = local.resourceGroupName
  location = var.location
  tags = {
    purpose = "demo"
  }
}

resource "azurerm_app_service_plan" "plan" {
  name                = local.planName
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "app" {
  name                = local.webAppName
  location            = azurerm_resource_group.group.location
  resource_group_name = azurerm_resource_group.group.name
  app_service_plan_id = azurerm_app_service_plan.plan.id
}
