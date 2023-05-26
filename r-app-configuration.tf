resource "azurerm_app_configuration" "app_configuration" {
  name = local.app_configuration_name

  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(local.default_tags, var.extra_tags)
}
