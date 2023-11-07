output "resource_group_id" {
  description = "The ID of the created Azure Resource Group"
  value       = azurerm_resource_group.rg_config.id
}
