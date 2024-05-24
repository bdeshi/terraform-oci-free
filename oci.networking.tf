resource "oci_core_vcn" "vcn" {
  compartment_id = oci_identity_compartment.compartment.id
  cidr_block     = var.vcn_cidr
  is_ipv6enabled = var.enable_ipv6
  display_name   = join("", [var.prefix, "vcn"])
  dns_label      = local.vcn_dns_label
  freeform_tags  = local.freeform_tags
}

resource "oci_core_internet_gateway" "igw" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = join("", [var.prefix, "igw"])
  freeform_tags  = local.freeform_tags
}

# https://docs.oracle.com/en-us/iaas/Content/API/SDKDocs/terraformbestpractices_topic-vcndefaults.htm

resource "oci_core_default_route_table" "vcn" {
  compartment_id             = oci_identity_compartment.compartment.id
  manage_default_resource_id = oci_core_vcn.vcn.default_route_table_id
  freeform_tags              = local.freeform_tags
  route_rules {
    network_entity_id = oci_core_internet_gateway.igw.id
    destination       = "0.0.0.0/0"
  }
}

resource "oci_core_security_list" "open_ports" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  display_name   = "all-open"
  freeform_tags  = local.freeform_tags
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

resource "oci_core_subnet" "public_subnet" {
  compartment_id = oci_identity_compartment.compartment.id
  vcn_id         = oci_core_vcn.vcn.id
  cidr_block     = var.vcn_cidr
  display_name   = "public"
  dns_label      = "public"
  route_table_id = oci_core_default_route_table.vcn.id
  security_list_ids = [
    oci_core_vcn.vcn.default_security_list_id,
    oci_core_security_list.open_ports.id
  ]
  freeform_tags = merge(local.freeform_tags, { type = "public" })
}
