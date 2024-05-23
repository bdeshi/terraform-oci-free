locals {
  common_description = "managed by terraform"
  freeform_tags = {
    ManagedBy       = "iac/terraform"
    "iac/source"    = var.iac_project_source
    "iac/component" = var.iac_project_name
  }
}
