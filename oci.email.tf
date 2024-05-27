resource "oci_email_email_domain" "domain" {
  for_each       = toset(var.enable_email_delivery ? var.email_configuration.email_domains : [])
  compartment_id = oci_identity_compartment.compartment.id
  name           = each.value
  freeform_tags  = local.freeform_tags
}

resource "oci_email_dkim" "domain" {
  for_each = toset(var.enable_email_delivery ? var.email_configuration.email_domains : [])

  email_domain_id = oci_email_email_domain.domain[each.value].id
  freeform_tags   = local.freeform_tags
}

resource "oci_email_sender" "sender" {
  for_each = toset(var.enable_email_delivery ? var.email_configuration.approved_senders : [])

  compartment_id = oci_identity_compartment.compartment.id
  email_address  = each.value
  freeform_tags  = local.freeform_tags
}

resource "oci_email_suppression" "suppression" {
  for_each = toset(var.enable_email_delivery ? var.email_configuration.suppression_list : [])

  compartment_id = oci_identity_compartment.compartment.id
  email_address  = each.value
}
