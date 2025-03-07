## Specific App Configuration parameters
variable "sku" {
  description = "The SKU name of the App Configuration. Possible values are `free` and `standard`. Defaults to `standard`."
  type        = string
  default     = "standard"
}

variable "purge_protection_enabled" {
  description = "Whether Purge Protection is enabled. This field only works for `standard` SKU. Defaults to `false`."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "The number of days that items should be retained for once soft-deleted. This field only works for `standard` sku. This value can be between `1 and 7` days. Defaults to 7. Changing this forces a new resource to be created."
  type        = number
  default     = 7

  validation {
    condition     = var.soft_delete_retention_days == null || (var.soft_delete_retention_days >= 1 && var.soft_delete_retention_days <= 7)
    error_message = "`soft_delete_retention_days` must be between 1 and 7 days."
  }
}

variable "local_auth_enabled" {
  description = "Whether local authentication methods is enabled. Defaults to `false`."
  type        = bool
  default     = false
}

variable "identity" {
  description = "Identity block information as described in this [documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_configuration#identity-1)."
  type = object({
    type         = optional(string, "SystemAssigned")
    identity_ids = optional(list(string))
  })
  default = {}

  validation {
    condition     = var.identity == null || contains(["SystemAssigned", "UserAssigned", "SystemAssigned, UserAssigned"], try(var.identity.type, "SystemAssigned"))
    error_message = "`var.identity.type` must be one of 'SystemAssigned', 'UserAssigned' or 'SystemAssigned, UserAssigned'."
  }
}

variable "paired_region_replication_enabled" {
  description = "Whether replication is enabled on paired region."
  type        = bool
  default     = false
}

variable "paired_region_replication_replica_custom_name" {
  description = "Custom replica name on paired region."
  type        = string
  default     = null
}

variable "custom_replica" {
  description = "Create one or multiple custom AppConfig replica."
  type = list(object({
    location = string
    name     = string
  }))
  default  = []
  nullable = false
}

variable "data_plane_proxy_authentication_mode" {
  description = "The data plane proxy authentication mode."
  type        = string
  default     = "Local"
}

variable "data_plane_proxy_private_link_delegation_enabled" {
  description = "Whether data plane proxy private link delegation is enabled."
  type        = bool
  default     = false
}
