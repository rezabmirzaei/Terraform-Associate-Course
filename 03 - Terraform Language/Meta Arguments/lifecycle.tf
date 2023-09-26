resource "azurerm_virtual_network" "vnet_lifecycle" {
  name                = "advanced-vnet"
  location            = "East US"
  resource_group_name = azurerm_resource_group.rg_meta.name
  address_space       = ["10.30.0.0/16"]

  # Define the lifecycle settings within a single "lifecycle" block.
  lifecycle {
    # Prevent the accidental destruction of the VNet.
    prevent_destroy = true
    # Ignore changes to the tags of this resource.
    ignore_changes = [tags]
  }

}
