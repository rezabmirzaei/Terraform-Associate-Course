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

# Variables allow you to parameterize your configuration, making it more flexible.
# You can define values for these variables in multiple ways (each step taking presedence over the previous):
# 1. By specifying default values in the "variables.tf" file.
# 2. By providing values in a "terraform.tfvars" file.
# 3. By creating custom files and using the "-var-file" flag when running Terraform commands.
# 4. By passing values using the "-var" flag when running Terraform commands.
resource "azurerm_resource_group" "rg_config" {
  # Using "var." to refernce a variable named "resource_group_name."
  name = var.resource_group_name
  # Using "var." to refernce a variable named "location."
  location = var.location
}
