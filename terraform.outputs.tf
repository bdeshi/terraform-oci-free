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
  sensitive   = true
}

output "admin_initial_password" {
  description = "The initial password of the admin user"
  value       = try(oci_identity_ui_password.admin_initial[0].password, null)
  sensitive   = true
}

output "admin_auth_token" {
  description = "The auth token of the admin user"
  value       = try(oci_identity_auth_token.admin[0].token, null)
  sensitive   = true
}

output "api_key_private" {
  description = "The private part of the admin user API key"
  value       = try(tls_private_key.admin_api_key[0].private_key_pem, null)
  sensitive   = true
}

output "api_key_fingerprint" {
  description = "The fingerprint of the admin user API key"
  value       = try(oci_identity_api_key.admin[0].fingerprint, null)
}

output "vcn_cidr_blocks" {
  description = "The CIDR block for the VCN"
  value       = oci_core_vcn.vcn.cidr_blocks
}

output "vcn_ipv6_cidr_blocks" {
  description = "The IPv6 CIDR block for the VCN"
  value       = oci_core_vcn.vcn.ipv6cidr_blocks
}

output "vcn_ipv6_cidr_private_blocks" {
  description = "The IPv6 CIDR block for the VCN"
  value       = oci_core_vcn.vcn.ipv6private_cidr_blocks
}

output "subnet_cidr_block" {
  description = "The CIDR block for the subnet"
  value       = oci_core_subnet.public.cidr_block
}

output "subnet_ipv6_cidr_block" {
  description = "The IPv6 CIDR block for the subnet"
  value       = oci_core_subnet.public.ipv6cidr_block
}

output "ssh_key_public" {
  description = "The public SSH key for the compute instances"
  value       = local.compute_ssh_key
}

output "ssh_key_private" {
  description = "The created SSH private key for the compute instances"
  value       = try(trimspace(tls_private_key.compute_ssh_key[0].private_key_pem), null)
  sensitive   = true
}

output "reserved_ip" {
  description = "The reserved public IP address"
  value       = oci_core_public_ip.static[0].ip_address
}

output "instance_ips" {
  description = "The public IP addresses of the instances"
  value       = { for k, v in oci_core_instance.compute : k => v.public_ip }
}

output "instance_availability_domains" {
  description = "The availability domains of the instances"
  value       = { for k, v in oci_core_instance.compute : k => v.availability_domain }
}

output "instance_selected_images" {
  description = "The selected images for each instance shape"
  value       = { for k, v in data.oci_core_images.selected : k => v.images[0].display_name }
}

output "email_endpoints" {
  description = "The email configuration endpoints"
  value = {
    http = data.oci_email_configuration.endpoints.http_submit_endpoint
    smtp = data.oci_email_configuration.endpoints.smtp_submit_endpoint
  }
}

output "kms_vault_id" {
  description = "The ID of the KMS vault"
  value       = oci_kms_vault.vault[0].id
}

output "kms_vault_endpoints" {
  description = "The KMS vault endpoints"
  value = {
    management = oci_kms_vault.vault[0].management_endpoint
    encryption = oci_kms_vault.vault[0].crypto_endpoint
  }
}

output "kms_key_ids" {
  description = "The IDs of the KMS keys"
  value       = { for k, v in oci_kms_key.key : k => v.id }
}
