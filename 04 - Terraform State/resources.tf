resource "azurerm_resource_group" "rg_state" {
  name     = "rg-terraform-state"
  location = "West Europe"
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "asp-terraform-state"
  resource_group_name = azurerm_resource_group.rg_state.name
  location            = azurerm_resource_group.rg_state.location
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "app_service" {
  name                = "app-terraform-state"
  location            = azurerm_resource_group.rg_state.location
  resource_group_name = azurerm_resource_group.rg_state.name
  service_plan_id     = azurerm_service_plan.app_service_plan.id

  site_config {
    always_on = false
  }

}
