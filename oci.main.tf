resource "oci_identity_compartment" "compartment" {
  compartment_id = var.tenancy_id
  name           = join("", [var.prefix, "compartment"])
  description    = local.common_description
  enable_delete  = true
  freeform_tags  = local.freeform_tags
}
