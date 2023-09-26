# Simple vnet, appropriatly tagged so that our data source further down finds it
resource "azurerm_virtual_network" "vnet_data" {
  name                = "vnet-terraform-data"
  location            = azurerm_resource_group.rg_data.location
  resource_group_name = azurerm_resource_group.rg_data.name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "Dev"
    role        = "Webserver"
  }
}

# Data source to retrieve resources with specific tags
data "azurerm_resources" "dev_web_data" {
  resource_group_name = "rg-terraform-data"
  required_tags = {
    environment = "Dev"
    role        = "Webserver"
  }
  depends_on = [azurerm_resource_group.rg_data]
}

# Output variable to display the IDs of all resource instances
output "resource_ids" {
  value = data.azurerm_resources.dev_web_data[*].id
}
