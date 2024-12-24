output "resource" {
  description = "App Configuration resource object."
  value       = azurerm_app_configuration.main
  sensitive   = true
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics
}

output "id" {
  description = "App Configuration ID."
  value       = azurerm_app_configuration.main.id
}

output "name" {
  description = "App Configuration name."
  value       = azurerm_app_configuration.main.name
}

output "identity_principal_id" {
  description = "App Configuration system identity principal ID."
  value       = one(azurerm_app_configuration.main.identity[*].principal_id)
}

output "primary_read_key" {
  description = "App Configuration primary read key."
  value       = azurerm_app_configuration.main.primary_read_key
  sensitive   = true
}

output "secondary_read_key" {
  description = "App Configuration secondary read key."
  value       = azurerm_app_configuration.main.secondary_read_key
  sensitive   = true
}

output "primary_write_key" {
  description = "App Configuration primary write key."
  value       = azurerm_app_configuration.main.primary_write_key
  sensitive   = true
}

output "secondary_write_key" {
  description = "App Configuration secondary write key."
  value       = azurerm_app_configuration.main.secondary_write_key
  sensitive   = true
}

output "endpoint" {
  description = "App Configuration Endpoint URL."
  value       = azurerm_app_configuration.main.endpoint
}
