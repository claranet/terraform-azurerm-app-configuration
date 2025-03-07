module "azure_region" {
  source  = "claranet/regions/azurerm"
  version = "~> 7.4.0"

  azure_region = var.location
}
