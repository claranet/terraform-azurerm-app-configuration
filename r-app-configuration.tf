resource "azurerm_app_configuration" "main" {
  name = local.name

  location            = var.location
  resource_group_name = var.resource_group_name

  sku = var.sku

  public_network_access      = var.public_network_access_enabled ? "Enabled" : "Disabled"
  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days
  local_auth_enabled         = var.local_auth_enabled

  data_plane_proxy_authentication_mode             = var.data_plane_proxy_authentication_mode
  data_plane_proxy_private_link_delegation_enabled = var.data_plane_proxy_private_link_delegation_enabled

  dynamic "identity" {
    for_each = var.identity[*]
    content {
      type         = identity.value.type
      identity_ids = endswith(var.identity.type, "UserAssigned") ? identity.value.identity_ids : null
    }
  }

  dynamic "replica" {
    for_each = var.custom_replica[*]
    content {
      location = replica.value.location
      name     = replica.value.name
    }
  }

  dynamic "replica" {
    for_each = var.paired_region_replication_enabled ? ["paired_region_replication"] : []
    content {
      location = module.azure_region.paired_location.location_cli
      name     = coalesce(var.paired_region_replication_replica_custom_name, module.azure_region.paired_location.location_short)
    }
  }

  tags = merge(local.default_tags, var.extra_tags)

  lifecycle {
    precondition {
      condition     = (var.data_plane_proxy_authentication_mode == "Local" && !var.data_plane_proxy_private_link_delegation_enabled) || (var.data_plane_proxy_authentication_mode == "Pass-through")
      error_message = "`data_plane_proxy_private_link_delegation_enabled` cannot be set to `true` when `data_plane_proxy_authentication_mode` is set to `Local`"
    }
  }
}

moved {
  from = azurerm_app_configuration.app_configuration
  to   = azurerm_app_configuration.main
}
