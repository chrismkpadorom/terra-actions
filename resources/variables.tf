variable "environment" {
  description = "The environment name that will be used in the RG Name and in Tags."
  type        = string
}
variable "location" {
  description = "The Azure Region the resources will be deployed to."
  type        = string
  default     = "cus"
}

variable "azureRegion" {
  description = "The Azure Region the resources will be deployed to."
  type        = string
  default     = "centralus"
}
