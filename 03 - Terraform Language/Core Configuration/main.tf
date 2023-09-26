terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.74.0"
    }
  }
  required_version = ">= 1.5.6"
}

# The default provider configuration; resources that begin with `azurerm_` will use it as the default.
provider "azurerm" {
  features {}
}

# Provider configuration for the east region.
provider "azurerm" {
  alias = "east"
  features {
    # In Azure, the default behavior is to retain the OS disk when deleting a virtual machine.
    # Enabling "delete_os_disk_on_deletion" ensures the OS disk is also deleted to avoid leaving residual resources.
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
  }
}

# Provider configuration for the west region.
provider "azurerm" {
  alias = "west"
  features {
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
  }
}

resource "azurerm_resource_group" "rg_east" {
  provider = azurerm.east
  name     = "rg-terraform-east"
  location = "East US"

}

resource "azurerm_resource_group" "rg_west" {
  provider = azurerm.west
  name     = "rg-terraform-west"
  location = "West US"
}
