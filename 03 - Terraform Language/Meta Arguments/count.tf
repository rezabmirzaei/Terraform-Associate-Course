# Define a local to specify the number of VNets to create
locals {
  vnet_count = 3
}
# Can also be defined as configurable variable
# variable "vnet_count" {
#   description = "Number of VNets to create"
#   default     = 3
# }

resource "azurerm_virtual_network" "vnet_count" {
  # Use the "count" argument to create multiple instances of this resource
  # The number of instances created will be determined by the value of the local variable
  count = local.vnet_count
  # Use this if "vnet_count" is defined as a variable
  # count             = var.vnet_count
  # Set the name of each VNet with a unique index using "count" (starts at "0" zero)
  # This allows each VNet to have a unique name.
  name                = "vnet-${count.index}"
  location            = azurerm_resource_group.rg_meta.location
  resource_group_name = azurerm_resource_group.rg_meta.name
  # Set the address space for each VNet with an incrementing index using "count"
  # This allows each VNet to have a unique address space
  address_space = ["10.${count.index}.0.0/16"]
}
