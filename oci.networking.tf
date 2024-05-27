resource "oci_core_vcn" "vcn" {
  compartment_id                   = oci_identity_compartment.compartment.id
  cidr_block                       = var.vcn_cidr
  is_ipv6enabled                   = var.enable_ipv6
  is_oracle_gua_allocation_enabled = true
  display_name                     = join("", [var.prefix, "vcn"])
  dns_label                        = local.vcn_dns_label
  freeform_tags                    = local.freeform_tags
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = join("", [var.prefix, "igw"])
  freeform_tags  = local.freeform_tags
}

# https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformbestpractices_topic-vcndefaults.htm

resource "oci_core_default_route_table" "default" {
  compartment_id             = oci_identity_compartment.compartment.id
  manage_default_resource_id = oci_core_vcn.vcn.default_route_table_id
  freeform_tags              = local.freeform_tags
  route_rules {
    network_entity_id = oci_core_internet_gateway.igw.id
    destination       = "0.0.0.0/0"
  }
}

resource "oci_core_default_security_list" "default" {
  compartment_id             = oci_identity_compartment.compartment.id
  manage_default_resource_id = oci_core_vcn.vcn.default_security_list_id
  freeform_tags              = local.freeform_tags
  egress_security_rules {
    destination = "0.0.0.0/0"
    protocol    = "all"
  }
  egress_security_rules {
    destination = "::/0"
    protocol    = "all"
  }
  ingress_security_rules {
    source   = "0.0.0.0/0"
    protocol = "all"
  }
  ingress_security_rules {
    source   = "::/0"
    protocol = "all"
  }
}

resource "oci_core_network_security_group" "default" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "default"
  freeform_tags  = local.freeform_tags
}

locals {
  nsg_default_rule_matrix = [
    { direction = "EGRESS", value = "0.0.0.0/0" },
    { direction = "EGRESS", value = "::/0" },
    { direction = "INGRESS", value = "0.0.0.0/0" },
    { direction = "INGRESS", value = "::/0" }
  ]
}

resource "oci_core_network_security_group_security_rule" "default" {
  for_each = zipmap(range(length(local.nsg_default_rule_matrix)), local.nsg_default_rule_matrix)

  network_security_group_id = oci_core_network_security_group.default.id
  direction                 = each.value.direction
  source_type               = each.value.direction == "INGRESS" ? try(each.value.type, "CIDR_BLOCK") : null
  source                    = each.value.direction == "INGRESS" ? each.value.value : null
  destination_type          = each.value.direction == "EGRESS" ? try(each.value.type, "CIDR_BLOCK") : null
  destination               = each.value.direction == "EGRESS" ? each.value.value : null
  protocol                  = try(each.value.protocol, "all")
}

resource "oci_core_subnet" "public" {
  compartment_id      = oci_identity_compartment.compartment.id
  vcn_id              = oci_core_vcn.vcn.id
  cidr_block          = cidrsubnets(oci_core_vcn.vcn.cidr_blocks[0], 8)[0]
  ipv6cidr_block      = var.enable_ipv6 ? cidrsubnets(oci_core_vcn.vcn.ipv6cidr_blocks[0], 8)[0] : null
  display_name        = "public"
  dns_label           = "public"
  availability_domain = null
  route_table_id      = oci_core_default_route_table.default.id
  security_list_ids   = [oci_core_default_security_list.default.id]
  freeform_tags       = merge(local.freeform_tags, { type = "public" })
}
