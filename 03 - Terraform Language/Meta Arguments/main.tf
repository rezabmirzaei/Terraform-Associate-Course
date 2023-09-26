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

resource "azurerm_resource_group" "rg_meta" {
  name     = "rg_meta"
  location = "Norway East"

}