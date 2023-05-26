data "azurecaf_name" "app_configuration" {
  name          = var.stack
  resource_type = "azurerm_app_configuration"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.location_short, var.environment, local.name_suffix])
  use_slug      = true
  clean_input   = true
  separator     = "-"
}
