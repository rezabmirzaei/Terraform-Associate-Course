variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-terraform-config"
}

variable "location" {
  description = "Location for the Azure Resource Group"
  type        = string
  default     = "Norway East"
}