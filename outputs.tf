output "app_configuration" {
  description = "App Configuration output object"
  value       = azurerm_app_configuration.app_configuration
}

output "id" {
  description = "App Configuration ID"
  value       = azurerm_app_configuration.app_configuration.id
}

output "name" {
  description = "App Configuration name"
  value       = azurerm_app_configuration.app_configuration.name
}

output "identity_principal_id" {
  description = "App Configuration system identity principal ID"
  value       = try(azurerm_app_configuration.app_configuration.identity[0].principal_id, null)
}
