variable "iac_project_name" {
  description = "The name of the iac project"
  type        = string
  default     = "oci-free"
}

variable "iac_project_source" {
  description = "The source repo of the iac project"
  type        = string
  default     = "https://git.bdeshi.space/bdeshi/terraform-oci-free.git"
}

variable "oci_region" {
  description = "The region for the OCI provider"
  type        = string
}

variable "oci_profile" {
  description = "The config file profile for the OCI provider"
  type        = string
  default     = null
}

variable "tenancy_id" {
  description = "The OCID of the tenancy"
  type        = string
}


variable "prefix" {
  description = "Name prefix for all resources"
  type        = string
  default     = "free-"
}

variable "admin_create_credentials" {
  type = object({
    api_key      = bool
    auth_token   = bool
    customer_key = bool
    password     = bool
  })
  default = {
    api_key      = true
    auth_token   = false
    customer_key = false
    password     = false
  }
  description = "Types of credentials to create for the admin user"
}

variable "vcn_cidr" {
  description = "The CIDR block for the VCN"
  type        = string
  default     = "10.0.0.0/16"
}

variable "enable_ipv6" {
  description = "Enable IPv6 for the VCN"
  type        = bool
  default     = true
}

variable "compute_ssh_key" {
  description = "The public SSH key for the compute instances"
  type        = string
  default     = null
}

variable "created_ssh_key_algorithm" {
  description = "The algorithm for the created SSH key"
  type        = string
  default     = "ED25519"
}
