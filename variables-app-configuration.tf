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

variable "identity_type" {
  description = "App configuration identity type. Possible values are `null` and `SystemAssigned`."
  type        = string
  default     = "SystemAssigned"
}
