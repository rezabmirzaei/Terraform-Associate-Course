# Simple vnet, created "count" number of times
resource "azurerm_virtual_network" "vnet_expressions" {
  count               = 3
  name                = "vnet-terraform-expressions-${count.index}"
  location            = azurerm_resource_group.rg_expressions.location
  resource_group_name = azurerm_resource_group.rg_expressions.name
  address_space       = ["10.0.0.0/16"]
}

# Output variable to display the names of all vnets created - USING FOR
output "vnet_names_for" {
  value = [for vnet in azurerm_virtual_network.vnet_expressions : vnet.name]
}

# Output variable to display the names of all vnets created - USING SPLAT
output "vnet_names_splat" {
  value = azurerm_virtual_network.vnet_expressions[*].name
}