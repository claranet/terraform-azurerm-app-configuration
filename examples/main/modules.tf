module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location    = module.azure_region.location
  client_name = var.client_name
  environment = var.environment
  stack       = var.stack
}

module "run" {
  source  = "claranet/run/azurerm"
  version = "x.x.x"

  client_name         = var.client_name
  environment         = var.environment
  stack               = var.stack
  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name

  monitoring_function_enabled = false
}

module "app_configuration" {
  source  = "claranet/app-configuration/azurerm"
  version = "x.x.x"

  location            = module.azure_region.location
  location_short      = module.azure_region.location_short
  resource_group_name = module.rg.resource_group_name

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  logs_destinations_ids = [
    module.run.logs_storage_account_id,
    module.run.log_analytics_workspace_id
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
