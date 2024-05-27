resource "tls_private_key" "compute_ssh_key" {
  count = var.supplied_compute_ssh_public_key == null ? 1 : 0

  algorithm = var.created_compute_ssh_key_algorithm
}

resource "oci_core_instance" "compute" {
  for_each = local.compute_for_each_value

  compartment_id      = oci_identity_compartment.compartment.id
  availability_domain = local.compute_availability_domains[each.value.key][0]
  display_name        = join("", [var.prefix, each.value.key, each.value.index])
  shape               = local.compute_shapes[each.value.key]
  dynamic "shape_config" {
    for_each = each.value.key == "flex" ? [1] : []
    content {
      memory_in_gbs = 24
      ocpus         = 4
    }
  }
  create_vnic_details {
    assign_ipv6ip  = var.enable_ipv6
    display_name   = join("", [var.prefix, each.value.key, each.value.index])
    hostname_label = join("", [local.compute_dns_labels[each.value.key], each.value.index])
    subnet_id      = oci_core_subnet.public.id
    nsg_ids        = [oci_core_network_security_group.default.id]
    freeform_tags  = merge(local.freeform_tags, { type = each.value.key })
  }
  is_pv_encryption_in_transit_enabled = true # only used on creation
  launch_options {
    is_pv_encryption_in_transit_enabled = true # only used on update
    is_consistent_volume_naming_enabled = true
    network_type                        = "PARAVIRTUALIZED"
  }
  source_details {
    source_type                     = "image"
    source_id                       = data.oci_core_images.selected[each.value.key].images[0].id
    boot_volume_size_in_gbs         = each.value.key == "flex" ? 100 : 50
    boot_volume_vpus_per_gb         = 120
    is_preserve_boot_volume_enabled = false
  }
  metadata = {
    ssh_authorized_keys = local.compute_ssh_key
    user_data           = try(file("${path.module}/files/user_data.${each.value.key}.sh"), null)
  }
  availability_config {
    is_live_migration_preferred = true
    recovery_action             = "RESTORE_INSTANCE"
  }
  freeform_tags = merge(local.freeform_tags, { type = each.value.key })

  lifecycle {
    ignore_changes = [
      # don't replace running instances when latest available image changes
      source_details.0.source_id
    ]
  }
}

resource "oci_core_public_ip" "static" {
  count          = var.create_static_ip ? 1 : 0
  compartment_id = oci_identity_compartment.compartment.id
  lifetime       = "RESERVED"
  display_name   = join("", [var.prefix, "static-ip"])
  # private_ip_id = var.attach_static_ip_to_flex ? data.oci_core_private_ips.flex.private_ips[0].id : null
}
