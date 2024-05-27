data "oci_identity_tenancy" "tenancy" {
  tenancy_id = var.tenancy_id
}

data "oci_email_configuration" "endpoints" {
  compartment_id = var.tenancy_id
}

# use this instead of oci_kms_key.key to await supporting policy creation
data "oci_kms_key" "key" {
  for_each = var.create_vault ? var.use_kms : {}

  management_endpoint = oci_kms_vault.vault[0].management_endpoint
  key_id              = oci_kms_key.key[each.key].id
  depends_on          = [oci_identity_policy.kms_service_policy]
}

data "oci_identity_availability_domains" "available" {
  compartment_id = oci_identity_compartment.compartment.id
}

data "oci_core_shapes" "available" {
  for_each = {
    for item in data.oci_identity_availability_domains.available.availability_domains :
    item.name => item
  }

  availability_domain = each.key
  compartment_id      = oci_identity_compartment.compartment.id
}

data "oci_core_images" "selected" {
  for_each         = try(local.compute_shapes, {})
  compartment_id   = oci_identity_compartment.compartment.id
  operating_system = "Canonical Ubuntu"
  shape            = each.value
  state            = "available"
  filter {
    name   = "display_name"
    values = ["^Canonical-Ubuntu-\\d{1,2}\\.\\d{1,2}-(aarch64-)?[\\.0-9-]+$"]
    regex  = true
  }
}

# data "oci_core_private_ips" "flex" {
#   count = (var.create_static_ip && var.attach_static_ip_to_flex) ? 1 : 0
#
#   ip_address = oci_core_instance.compute["flex_1"].private_ip
#   subnet_id  = oci_core_subnet.public.id
# }
