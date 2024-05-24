resource "oci_identity_group" "administrators" {
  compartment_id = var.tenancy_id
  name           = join("", [var.prefix, "administrators"])
  description    = local.common_description
  freeform_tags  = local.freeform_tags
}

resource "oci_identity_policy" "administrators" {
  compartment_id = oci_identity_compartment.compartment.id
  name           = join("", [var.prefix, "administrators"])
  description    = local.common_description
  statements = [
    "ALLOW group ${oci_identity_group.administrators.name} TO manage all-resources IN compartment ${oci_identity_compartment.compartment.name}"
  ]
  freeform_tags = local.freeform_tags
}

resource "oci_identity_user" "admin" {
  compartment_id = var.tenancy_id
  name           = join("", [var.prefix, "admin"])
  description    = local.common_description
  freeform_tags  = local.freeform_tags
}

resource "oci_identity_user_group_membership" "admin" {
  group_id = oci_identity_group.administrators.id
  user_id  = oci_identity_user.admin.id
}

resource "oci_identity_customer_secret_key" "admin" {
  count = var.admin_create_credentials.customer_key ? 1 : 0

  display_name = join("", [var.prefix, "admin"])
  user_id      = oci_identity_user.admin.id
}

resource "oci_identity_ui_password" "admin_initial" {
  count = var.admin_create_credentials.password ? 1 : 0

  user_id = oci_identity_user.admin.id
}

resource "oci_identity_auth_token" "admin" {
  count = var.admin_create_credentials.auth_token ? 1 : 0

  user_id     = oci_identity_user.admin.id
  description = local.common_description
}

resource "tls_private_key" "admin_api_key" {
  count = var.admin_create_credentials.api_key ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "oci_identity_api_key" "admin" {
  count = var.admin_create_credentials.api_key ? 1 : 0

  user_id   = oci_identity_user.admin.id
  key_value = trimspace(tls_private_key.admin_api_key[0].public_key_pem)
}
