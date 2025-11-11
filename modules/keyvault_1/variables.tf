variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}
variable "tenant_id" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "enable_rbac_authorization" {
  type = bool
}

variable "tags" {
  type        = map(string)
  description = "Additional default tags to add to the resources being deployed at this layer. Application, Environment and Level are added by default"
}

variable "public_network_access_enabled" {
  type = string
  description = "Enable / disable public access"
  default = false
}

variable "diag_storage_id" {
  type = string
  description = "Resource ID of Storage for the logs"
}

variable "purge_protection_enabled" {
  type =  bool
  description = "Enable / disable purge protection"
  default = false
}

