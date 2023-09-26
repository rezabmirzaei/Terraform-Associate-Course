# This is the Terraform configuration block that defines the required providers.
# It specifies that the "azurerm" provider is required, and it should be sourced
# from the "hashicorp/azurerm" namespace with a version constraint of at least 3.0.2.
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.74.0"
    }
  }

  # This sets the minimum required Terraform version to 1.1.0 for this configuration.
  required_version = ">= 1.5.6"
}

# This block defines the Azure provider configuration, which will be used to
# interact with Microsoft Azure services. The "features" block is left empty in
# this example, but additional provider configuration can be added within it.
provider "azurerm" {
  features {}
}

# This block defines an Azure resource of type "azurerm_resource_group" with the
# name "rg-tf-basics." It specifies the name and location for the Azure resource group.
resource "azurerm_resource_group" "rg_basics" {
  name     = "rg-terraform-basics" # Name of the Azure resource group.
  location = "Norway East"         # Location or region where the resource group will be created.
}
