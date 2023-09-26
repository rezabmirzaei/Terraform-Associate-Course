terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.74.0"
    }
  }
  required_version = ">= 1.5.6"
}

provider "azurerm" {
  features {}
}

# Define an input variable for the Azure region
variable "location" {
  type    = string
  default = "Norway East" # Default value for the location variable
}

# Define a local variable for the address space (to avoid potential redundancy)
locals {
  address_space = "10.0.0.0/16"
}

# Define an output value to expose the virtual network ID (will be set after 'terraform apply')
output "vnet_id" {
  value = azurerm_virtual_network.vnet_example.id
}

# Create an Azure resource group using the input variable
resource "azurerm_resource_group" "rg_vars" {
  name     = "rg-terraform-vars" # Use the input variable for location
  location = var.location
}

# Create an Azure virtual network using the input variable and local variable
resource "azurerm_virtual_network" "vnet_example" {
  name                = "vnet-example"
  resource_group_name = azurerm_resource_group.rg_vars.name
  location            = var.location          # Use the input variable for location
  address_space       = [local.address_space] # Use the local variable for address space
}
