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

output "primary_read_key" {
  description = "App Configuration primary read key"
  value       = azurerm_app_configuration.app_configuration.primary_read_key
  sensitive   = true
}

output "secondary_read_key" {
  description = "App Configuration secondary read key"
  value       = azurerm_app_configuration.app_configuration.secondary_read_key
  sensitive   = true
}

output "primary_write_key" {
  description = "App Configuration primary write key"
  value       = azurerm_app_configuration.app_configuration.primary_write_key
  sensitive   = true
}

output "secondary_write_key" {
  description = "App Configuration secondary write key"
  value       = azurerm_app_configuration.app_configuration.secondary_write_key
  sensitive   = true
}

output "endpoint" {
  description = "App Configuration Endpoint URL"
  value       = azurerm_app_configuration.app_configuration.endpoint
}
