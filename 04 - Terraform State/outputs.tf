output "app_service_url" {
  value = azurerm_linux_web_app.app_service.default_hostname
}