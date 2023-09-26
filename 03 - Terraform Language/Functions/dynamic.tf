# Define a variable for subnet configurations
variable "subnets" {
  type = map(string)
  default = {
    "subnet1" = "10.0.1.0/24"
    "subnet2" = "10.0.2.0/24"
  }
}

# Create a virtual network setting the subnets using a dynamic block
resource "azurerm_virtual_network" "vnet_dynamic" {
  name                = "my-vnet"
  location            = azurerm_resource_group.rg_functions.location
  resource_group_name = azurerm_resource_group.rg_functions.name
  address_space       = ["10.0.0.0/16"]

  dynamic "subnet" {
    for_each = var.subnets
    content {
      name           = subnet.key
      address_prefix = subnet.value
    }
  }

}

