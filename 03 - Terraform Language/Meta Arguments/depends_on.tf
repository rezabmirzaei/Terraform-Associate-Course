# Terraform implicitly resolves dependencies based on the references made within the resource block
resource "azurerm_virtual_network" "vnet_implicit" {
  name                = "vnet-east"
  location            = azurerm_resource_group.rg_meta.location
  resource_group_name = azurerm_resource_group.rg_meta.name
  address_space       = ["10.0.0.0/16"]
}

# Explicitly uses the depends_on argument to override Terraform's implicit dependency resolution
resource "azurerm_virtual_network" "vnet_explicit" {
  name                = "vnet-west"
  location            = azurerm_resource_group.rg_meta.location
  resource_group_name = azurerm_resource_group.rg_meta.name
  address_space       = ["10.1.0.0/16"]
  # Explicitly specify a dependency on the resource group in the West region
  # This ensures that the resource group is created before the VNet
  depends_on = [azurerm_resource_group.rg_meta]
}
