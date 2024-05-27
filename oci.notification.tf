resource "oci_ons_notification_topic" "topic" {
  for_each       = var.create_topics ? var.topics : {}
  compartment_id = oci_identity_compartment.compartment.id
  name           = each.key
  description    = try(each.value.description, null)
  freeform_tags  = local.freeform_tags
}

resource "oci_ons_subscription" "subscription" {
  for_each = var.create_topics ? local.topic_subscriptions : toset([])

  compartment_id = oci_identity_compartment.compartment.id
  topic_id       = oci_ons_notification_topic.topic[each.value.topic].id
  protocol       = each.value.protocol
  endpoint       = each.value.endpoint
  freeform_tags  = local.freeform_tags
}
