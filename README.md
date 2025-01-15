# Azure App Configuration
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/app-configuration/azurerm/)

Azure module to deploy an [Azure App Configuration](https://learn.microsoft.com/en-us/azure/azure-app-configuration/overview).

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
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
```

## Providers

| Name | Version |
|------|---------|
| azurecaf | ~> 1.2, >= 1.2.22 |
| azurerm | ~> 3.74 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| azure\_region | claranet/regions/azurerm | ~> 7.3.0 |
| diagnostics | claranet/diagnostic-settings/azurerm | ~> 7.0.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_app_configuration.app_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration) | resource |
| [azurecaf_name.app_configuration](https://registry.terraform.io/providers/claranet/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings, name will be 'default' if not set. | `string` | `"default"` | no |
| custom\_name | Custom App Configuration, generated if not set | `string` | `""` | no |
| custom\_replica | Create one or multiple custom AppConfig replica. | <pre>list(object({<br/>    location = string<br/>    name     = string<br/>  }))</pre> | `[]` | no |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Additional tags to add on resources. | `map(string)` | `{}` | no |
| identity\_type | App configuration identity type. Possible values are `null` and `SystemAssigned`. | `string` | `"SystemAssigned"` | no |
| local\_auth\_enabled | Whether local authentication methods is enabled. Defaults to `false`. | `bool` | `false` | no |
| location | Azure region to use. | `string` | n/a | yes |
| location\_short | Short string for Azure location. | `string` | n/a | yes |
| logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br/>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br/>If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formated string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | n/a | yes |
| logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| name\_prefix | Optional prefix for the generated name | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name | `string` | `""` | no |
| paired\_region\_replication\_enabled | Whether replication is enabled on paired region. | `bool` | `false` | no |
| paired\_region\_replication\_replica\_custom\_name | Custom replica name on paired region. | `string` | `null` | no |
| public\_network\_access\_enabled | Whether the App Configuration is available from public network. | `bool` | `false` | no |
| purge\_protection\_enabled | Whether Purge Protection is enabled. This field only works for `standard` SKU. Defaults to `false`. | `bool` | `false` | no |
| resource\_group\_name | Name of the resource group. | `string` | n/a | yes |
| sku | The SKU name of the App Configuration. Possible values are `free` and `standard`. Defaults to `standard`. | `string` | `"standard"` | no |
| soft\_delete\_retention\_days | The number of days that items should be retained for once soft-deleted. This field only works for `standard` sku. This value can be between `1 and 7` days. Defaults to 7. Changing this forces a new resource to be created. | `number` | `7` | no |
| stack | Project stack name. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| app\_configuration | App Configuration output object |
| endpoint | App Configuration Endpoint URL |
| id | App Configuration ID |
| identity\_principal\_id | App Configuration system identity principal ID |
| name | App Configuration name |
| primary\_read\_key | App Configuration primary read key |
| primary\_write\_key | App Configuration primary write key |
| secondary\_read\_key | App Configuration secondary read key |
| secondary\_write\_key | App Configuration secondary write key |
<!-- END_TF_DOCS -->

## Related documentation

Microsoft Azure documentation: [learn.microsoft.com/en-us/azure/azure-app-configuration/overview](https://learn.microsoft.com/en-us/azure/azure-app-configuration/overview)
