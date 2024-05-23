output "tenancy_id" {
  description = "The ID of the tenancy"
  value       = var.tenancy_id
}

output "tenancy_name" {
  description = "The name of the tenancy"
  value       = data.oci_identity_tenancy.tenancy.name
}

output "compartment_id" {
  description = "The ID of the created compartment"
  value       = oci_identity_compartment.compartment.id
}

output "compartment_name" {
  description = "The name of the created compartment"
  value       = oci_identity_compartment.compartment.name
}

output "admin_user_id" {
  description = "The ID of the admin user"
  value       = oci_identity_user.admin.id
}

output "customer_key_id" {
  description = "The ID of the customer key"
  value       = try(oci_identity_customer_secret_key.admin[0].id, null)
}

output "customer_key_key" {
  description = "The ID of the customer key"
  value       = try(oci_identity_customer_secret_key.admin[0].key, null)
  sensitive = true
}

output "admin_initial_password" {
  description = "The initial password of the admin user"
  value       = try(oci_identity_ui_password.admin_initial[0].password, null)
  sensitive = true
}

output "admin_auth_token" {
  description = "The auth token of the admin user"
  value       = try(oci_identity_auth_token.admin[0].token, null)
  sensitive = true
}

output "api_key_private" {
  description = "The private part of the admin user API key"
  value       = try(tls_private_key.admin_api_key[0].private_key_pem, null)
  sensitive = true
}

output "api_key_fingerprint" {
  description = "The fingerprint of the admin user API key"
  value       = try(oci_identity_api_key.admin[0].fingerprint, null)
}
