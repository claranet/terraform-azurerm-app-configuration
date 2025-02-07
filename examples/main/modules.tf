module "app_configuration" {
  source  = "claranet/app-configuration/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  logs_destinations_ids = [
    module.logs.storage_account_id,
    module.logs.id
  ]

  paired_region_replication_enabled = true

  custom_replica = [
    {
      location = "westeurope"
      name     = "euwest"
    }
  ]

  extra_tags = {
    foo = "bar"
  }
}
