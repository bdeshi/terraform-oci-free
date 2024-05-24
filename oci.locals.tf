locals {
  common_description = "managed by terraform"
  freeform_tags = {
    ManagedBy       = "iac/terraform"
    "iac/source"    = var.iac_project_source
    "iac/component" = var.iac_project_name
  }
  # vcn dns label must be only alphanumeric and max 15 chars
  vcn_dns_label   = substr(replace(join("", [var.prefix, "vcn"]), "/(?i)[^0-9a-z]/", ""), 0, 15)
}
