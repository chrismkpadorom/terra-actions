## Shared Properties ##

variable "location" {
  type        = string
  description = "This is the programatic Azure DataCenter name the resources will be created in"
}
variable "tags" {
  type        = map(string)
  description = "Additional default tags to add to the resources being deployed at this layer. Application, Environment and Level are added by default"
}

## Module Properties ##
variable "storage_account_resource_group_name" {
  description = "The Storage Account Resource Group Name that will host a Storage Account V2 Private hosting blobs"
}

variable "name" {
  type        = string
  description = "The object name of the Storage Account V2 Private hosting blobs"
}

variable "storage_account_replication_type" {
  type        = string
  description = "The Storage Account Replication Type"
  default     = "LRS"
  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.storage_account_replication_type)
    error_message = "The sku must be one of: LRS, GRS, RAGRS, ZRS, GZRS, or RAGZRS."
  }
}

variable "storage_account_access_tier" {
  type        = string
  description = "The Storage Account Access Tier"
  default     = "Hot"
  validation {
    condition     = contains(["Hot", "Cool"], var.storage_account_access_tier)
    error_message = "The sku must be one of Hot or Cool."
  }
}

variable "is_hns_enabled" {
  type        = bool
  description = "Is Hierarchical Namespace or Gen2 SKU in the Storage Account.  Note this generally not have as deep of backup/soft delete options."
  default     = false
}

variable "cross_tenant_replication_enabled" {
  type        = bool
  description = "Allows for Cross Tenant replication (default = false)"
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Allow public access to this resource (default = true)"
  default     = false
}

variable "enable_static_website" {
  type        = bool
  description = "Controls if static website to be enabled on storage account (default = false)"
  default     = false
}

variable "index_path" {
  type        = string
  description = "path for index page"
  default     = "index.html"
}

variable "custom_404_path" {
  type        = string
  description = "path for custom 404 page"
  default     = "404.html"
}

variable "use_databricks_subnets" {
  type        = bool
  description = "Controls if we are to allow databricks subnets ( default = false)."
  default     = false
}

variable "retention_policy" {
  type = bool
  description = "Controls if we want to allow blob and container soft delete retention"
  default = false
  
}

variable "retention_days" {
  type = number
  description = "Specify of days want to keep blob and container retention"
  default = 14
  
}