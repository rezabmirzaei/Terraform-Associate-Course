# Create multiple Azure Resource Groups using a "for_each" statement.
resource "azurerm_resource_group" "rg_each" {
  # Define a map with keys and values representing resource group names and their locations.
  for_each = {
    first_rg  = "East US"
    second_rg = "West US"
  }
  # Use "each.key" as the name for each resource group and "each.value" as the location.
  name     = each.key
  location = each.value
}

# A more complicated example with a variable and "for_each."
variable "vnets" {
  description = "Map of VNets to create"
  type = map(object({
    location      = string
    address_space = list(string)
  }))
  default = {
    east-vnet = {
      location      = "East US"
      address_space = ["10.10.0.0/16"]
    },
    west-vnet = {
      location      = "West US"
      address_space = ["10.20.0.0/16"]
    },
  }
}

# Create Azure Virtual Networks based on the variable "vnets" using "for_each."
resource "azurerm_virtual_network" "vnets" {
  # Iterate through the "vnets" map, creating a VNet for each entry.
  for_each = var.vnets
  # Use "each.key" as the name for each VNet.
  name = each.key
  # Use "each.value.location" for the location, taken from the variable.
  location = each.value.location
  # Use the name of the resource group created earlier based on the "for_each" block.
  resource_group_name = azurerm_resource_group.rg_each["first_rg"].name
  # Use "each.value.address_space" for the VNet's address space, taken from the variable.
  address_space = each.value.address_space
}
