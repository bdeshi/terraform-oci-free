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

variable "create_vault" {
  description = "Create vault"
  type        = bool
  default     = true
}

variable "use_vault" {
  description = "Use created vault for key creation and management"
  type = object({
    volume   = bool
    object   = bool
    database = bool
  })
  default = {
    volume   = true
    object   = true
    database = true
  }
}

variable "supplied_compute_ssh_public_key" {
  description = "A pre-created public SSH key for the compute instances"
  type        = string
  default     = null
}

variable "created_compute_ssh_key_algorithm" {
  description = "The algorithm for the created SSH key if no key is provided"
  type        = string
  default     = "ED25519"
  validation {
    error_message = "created_compute_ssh_key_algorithm must be 'RSA', 'ECDSA' or 'ED25519'"
    condition     = contains(["RSA", "ECDSA", "ED25519"], var.created_compute_ssh_key_algorithm)
  }
}

variable "create_instances" {
  description = "Create compute instances types"
  type = object({
    micro = bool
    flex  = bool
  })
  default = {
    micro = true
    flex  = true
  }
}

variable "create_static_ip" {
  description = "Create a reserved static IP"
  type        = bool
  default     = true
}

variable "attach_static_ip_to_flex" {
  description = "Attach reserved static IP to flex instance"
  type        = bool
  default     = true
}

variable "create_databases" {
  description = "Create databases"
  type        = bool
  default     = true
}

variable "db_types" {
  description = "Types of database workloads to create"
  type        = list(string)
  default     = []
  # validate that each entry is a valid workload type
  validation {
    error_message = "db_types must be a list of 'OLTP', 'DW', 'AJD' or 'APEX'"
    condition     = alltrue([for v in var.db_types : contains(["OLTP", "DW", "AJD", "APEX"], v)])
  }
}

variable "enable_email_delivery" {
  description = "Create email delivery supporting configurations"
  type        = bool
  default     = true
}

variable "email_configuration" {
  description = "values for email configuration"
  type = object({
    email_domains    = list(string)
    approved_senders = list(string)
    suppression_list = list(string)
  })
  default = {
    email_domains    = []
    approved_senders = []
    suppression_list = []
  }
}

variable "create_notification_topics" {
  description = "Create notification topics"
  type        = bool
  default     = true
}

variable "topic_configuration" {
  description = "Values for notification topics configuration"
  type        = any
  default     = {}
}

variable "enable_object_storage" {
  description = "Create object storage bucket supporting configuration"
  type        = bool
  default     = true
}

variable "object_storage_buckets" {
  description = "Values for object storage buckets to create"
  type        = any
  default     = {}
}
