locals {
  common_description = "managed by terraform"
  freeform_tags = {
    ManagedBy       = "iac/terraform"
    "iac/source"    = var.iac_project_source
    "iac/component" = var.iac_project_name
  }
  # dns label must be only alphanumeric and max 15 chars
  vcn_dns_label = substr(replace(join("", [var.prefix, "vcn"]), "/(?i)[^0-9a-z]/", ""), 0, 15)
  compute_dns_labels = {
    # reduce 1 from max length because an index suffix gets added later
    micro = substr(replace(join("", [var.prefix, "micro"]), "/(?i)[^0-9a-z]/", ""), 0, 14)
    flex  = substr(replace(join("", [var.prefix, "flex"]), "/(?i)[^0-9a-z]/", ""), 0, 14)
  }
  compute_ssh_key = coalesce(
    var.supplied_compute_ssh_public_key,
    trimspace(tls_private_key.compute_ssh_key[0].public_key_openssh)
  )

  compute_shapes = {
    micro = "VM.Standard.E2.1.Micro"
    flex  = "VM.Standard.A1.Flex"
  }

  compute_counts = {
    micro = var.create_instances.micro ? 2 : 0
    flex  = var.create_instances.flex ? 1 : 0
  }

  compute_availability_domains = {
    micro = !var.create_instances.micro ? [] : [
      for domain, value in data.oci_core_shapes.available :
      domain if contains(value.shapes[*].name, local.compute_shapes.micro)
    ]
    flex = !var.create_instances.flex ? [] : [
      for domain, value in data.oci_core_shapes.available :
      domain if contains(value.shapes[*].name, local.compute_shapes.flex)
    ]
  }

  # { micro_1 = micro, micro_2 = micro, flex_1 = flex }
  compute_for_each_value = {
    for item in toset(flatten([
      for shape in keys(local.compute_shapes) : [
        for n in range(local.compute_counts[shape]) : "${shape}_${n + 1}"
    ]])) :
    item => {
      key   = split("_", item)[0]
      index = split("_", item)[1]
    }
  }

  topic_subscriptions = values({ for k, v in var.topics :
    k => { for i, s in v.subscriptions : "${k}_${i}" => {
      topic    = k
      protocol = s.protocol
      endpoint = s.endpoint
    } }
  })
}
