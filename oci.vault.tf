resource "oci_kms_vault" "vault" {
  count = var.create_vault ? 1 : 0

  compartment_id = oci_identity_compartment.compartment.id
  display_name   = join("", [var.prefix, "vault"])
  vault_type     = "DEFAULT"
  freeform_tags  = local.freeform_tags
}

resource "oci_kms_key" "key" {
  for_each = var.create_vault ? var.use_vault : {}

  compartment_id      = oci_identity_compartment.compartment.id
  management_endpoint = oci_kms_vault.vault[0].management_endpoint
  display_name        = join("", [var.prefix, each.key, "-key"])
  desired_state       = "ENABLED"
  protection_mode     = "HSM"
  key_shape {
    algorithm = "AES"
    length    = 32
  }
  freeform_tags = local.freeform_tags
}

resource "oci_identity_policy" "kms_service_policy" {
  compartment_id = oci_identity_compartment.compartment.id
  name           = "kms-service-policy"
  description    = "kms service policy"
  statements = [
    !var.use_vault.volume ? "" :
    "allow service blockstorage to use keys in compartment '${oci_identity_compartment.compartment.name}' where target.key.id='${oci_kms_key.key["volume"].id}'",
    !var.use_vault.object ? "" :
    "allow service objectstorage-${var.oci_region} to use keys in compartment '${oci_identity_compartment.compartment.name}' where target.key.id='${oci_kms_key.key["object"].id}'",
    !var.use_vault.database ? "" :
    "allow service dbcs to use keys in compartment '${oci_identity_compartment.compartment.name}' where target.key.id='${oci_kms_key.key["database"].id}'",
  ]
  freeform_tags = local.freeform_tags
}
