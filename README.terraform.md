<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | ~> 5.43.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.43.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_core_default_route_table.default](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_default_route_table) | resource |
| [oci_core_default_security_list.default](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_default_security_list) | resource |
| [oci_core_instance.compute](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_instance) | resource |
| [oci_core_internet_gateway.igw](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_internet_gateway) | resource |
| [oci_core_network_security_group.default](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_network_security_group) | resource |
| [oci_core_network_security_group_security_rule.default](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_network_security_group_security_rule) | resource |
| [oci_core_public_ip.static](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_public_ip) | resource |
| [oci_core_subnet.public](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_subnet) | resource |
| [oci_core_vcn.vcn](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/core_vcn) | resource |
| [oci_email_email_domain.domain](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/email_email_domain) | resource |
| [oci_email_sender.sender](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/email_sender) | resource |
| [oci_email_suppression.suppression](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/email_suppression) | resource |
| [oci_identity_api_key.admin](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_api_key) | resource |
| [oci_identity_auth_token.admin](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_auth_token) | resource |
| [oci_identity_compartment.compartment](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_compartment) | resource |
| [oci_identity_customer_secret_key.admin](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_customer_secret_key) | resource |
| [oci_identity_group.administrators](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_group) | resource |
| [oci_identity_policy.administrators](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy) | resource |
| [oci_identity_policy.kms_service_policy](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy) | resource |
| [oci_identity_ui_password.admin_initial](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_ui_password) | resource |
| [oci_identity_user.admin](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_user) | resource |
| [oci_identity_user_group_membership.admin](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_user_group_membership) | resource |
| [oci_kms_key.key](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_key) | resource |
| [oci_kms_vault.vault](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/kms_vault) | resource |
| [oci_ons_notification_topic.topic](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/ons_notification_topic) | resource |
| [oci_ons_subscription.subscription](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/ons_subscription) | resource |
| [tls_private_key.admin_api_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.compute_ssh_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [oci_core_images.selected](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_images) | data source |
| [oci_core_shapes.available](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/core_shapes) | data source |
| [oci_email_configuration.endpoints](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/email_configuration) | data source |
| [oci_identity_availability_domains.available](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_availability_domains) | data source |
| [oci_identity_tenancy.tenancy](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_tenancy) | data source |
| [oci_kms_key.key](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/kms_key) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_oci_region"></a> [oci\_region](#input\_oci\_region) | The region for the OCI provider | `string` | n/a | yes |
| <a name="input_tenancy_id"></a> [tenancy\_id](#input\_tenancy\_id) | The OCID of the tenancy | `string` | n/a | yes |
| <a name="input_admin_create_credentials"></a> [admin\_create\_credentials](#input\_admin\_create\_credentials) | Types of credentials to create for the admin user | <pre>object({<br>    api_key      = bool<br>    auth_token   = bool<br>    customer_key = bool<br>    password     = bool<br>  })</pre> | <pre>{<br>  "api_key": true,<br>  "auth_token": false,<br>  "customer_key": false,<br>  "password": false<br>}</pre> | no |
| <a name="input_create_instances"></a> [create\_instances](#input\_create\_instances) | Create compute instances types | <pre>object({<br>    micro = bool<br>    flex  = bool<br>  })</pre> | <pre>{<br>  "flex": true,<br>  "micro": true<br>}</pre> | no |
| <a name="input_create_static_ip"></a> [create\_static\_ip](#input\_create\_static\_ip) | Create a reserved static IP | `bool` | `true` | no |
| <a name="input_create_topics"></a> [create\_topics](#input\_create\_topics) | Create notification topics | `bool` | `true` | no |
| <a name="input_create_vault"></a> [create\_vault](#input\_create\_vault) | Create vault | `bool` | `true` | no |
| <a name="input_created_compute_ssh_key_algorithm"></a> [created\_compute\_ssh\_key\_algorithm](#input\_created\_compute\_ssh\_key\_algorithm) | The algorithm for the created SSH key if no key is provided | `string` | `"ED25519"` | no |
| <a name="input_email_configuration"></a> [email\_configuration](#input\_email\_configuration) | values for email configuration | <pre>object({<br>    email_domains    = list(string)<br>    approved_senders = list(string)<br>    suppression_list = list(string)<br>  })</pre> | <pre>{<br>  "approved_senders": [],<br>  "email_domains": [],<br>  "suppression_list": []<br>}</pre> | no |
| <a name="input_enable_email_delivery"></a> [enable\_email\_delivery](#input\_enable\_email\_delivery) | Create email delivery supporting configurations | `bool` | `true` | no |
| <a name="input_enable_ipv6"></a> [enable\_ipv6](#input\_enable\_ipv6) | Enable IPv6 for the VCN | `bool` | `true` | no |
| <a name="input_iac_project_name"></a> [iac\_project\_name](#input\_iac\_project\_name) | The name of the iac project | `string` | `"oci-free"` | no |
| <a name="input_iac_project_source"></a> [iac\_project\_source](#input\_iac\_project\_source) | The source repo of the iac project | `string` | `"https://git.bdeshi.space/bdeshi/terraform-oci-free.git"` | no |
| <a name="input_oci_profile"></a> [oci\_profile](#input\_oci\_profile) | The config file profile for the OCI provider | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix for all resources | `string` | `"free-"` | no |
| <a name="input_supplied_compute_ssh_public_key"></a> [supplied\_compute\_ssh\_public\_key](#input\_supplied\_compute\_ssh\_public\_key) | A pre-created public SSH key for the compute instances | `string` | `null` | no |
| <a name="input_topics"></a> [topics](#input\_topics) | Values for notification topics configuration | <pre>map(object({<br>    description = string<br>    subscriptions = list(object({<br>      protocol = string<br>      endpoint = string<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_use_kms"></a> [use\_kms](#input\_use\_kms) | Use created vault for key creation and management | <pre>object({<br>    volume   = bool<br>    object   = bool<br>    database = bool<br>  })</pre> | <pre>{<br>  "database": true,<br>  "object": true,<br>  "volume": true<br>}</pre> | no |
| <a name="input_vcn_cidr"></a> [vcn\_cidr](#input\_vcn\_cidr) | The CIDR block for the VCN | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_auth_token"></a> [admin\_auth\_token](#output\_admin\_auth\_token) | The auth token of the admin user |
| <a name="output_admin_initial_password"></a> [admin\_initial\_password](#output\_admin\_initial\_password) | The initial password of the admin user |
| <a name="output_admin_user_id"></a> [admin\_user\_id](#output\_admin\_user\_id) | The ID of the admin user |
| <a name="output_api_key_fingerprint"></a> [api\_key\_fingerprint](#output\_api\_key\_fingerprint) | The fingerprint of the admin user API key |
| <a name="output_api_key_private"></a> [api\_key\_private](#output\_api\_key\_private) | The private part of the admin user API key |
| <a name="output_compartment_id"></a> [compartment\_id](#output\_compartment\_id) | The ID of the created compartment |
| <a name="output_compartment_name"></a> [compartment\_name](#output\_compartment\_name) | The name of the created compartment |
| <a name="output_customer_key_id"></a> [customer\_key\_id](#output\_customer\_key\_id) | The ID of the customer key |
| <a name="output_customer_key_key"></a> [customer\_key\_key](#output\_customer\_key\_key) | The ID of the customer key |
| <a name="output_email_endpoints"></a> [email\_endpoints](#output\_email\_endpoints) | The email configuration endpoints |
| <a name="output_instance_availability_domains"></a> [instance\_availability\_domains](#output\_instance\_availability\_domains) | The availability domains of the instances |
| <a name="output_instance_ips"></a> [instance\_ips](#output\_instance\_ips) | The public IP addresses of the instances |
| <a name="output_instance_selected_images"></a> [instance\_selected\_images](#output\_instance\_selected\_images) | The selected images for each instance shape |
| <a name="output_kms_key_ids"></a> [kms\_key\_ids](#output\_kms\_key\_ids) | The IDs of the KMS keys |
| <a name="output_kms_vault_endpoints"></a> [kms\_vault\_endpoints](#output\_kms\_vault\_endpoints) | The KMS vault endpoints |
| <a name="output_kms_vault_id"></a> [kms\_vault\_id](#output\_kms\_vault\_id) | The ID of the KMS vault |
| <a name="output_reserved_ip"></a> [reserved\_ip](#output\_reserved\_ip) | The reserved public IP address |
| <a name="output_ssh_key_private"></a> [ssh\_key\_private](#output\_ssh\_key\_private) | The created SSH private key for the compute instances |
| <a name="output_ssh_key_public"></a> [ssh\_key\_public](#output\_ssh\_key\_public) | The public SSH key for the compute instances |
| <a name="output_subnet_cidr_block"></a> [subnet\_cidr\_block](#output\_subnet\_cidr\_block) | The CIDR block for the subnet |
| <a name="output_subnet_ipv6_cidr_block"></a> [subnet\_ipv6\_cidr\_block](#output\_subnet\_ipv6\_cidr\_block) | The IPv6 CIDR block for the subnet |
| <a name="output_tenancy_id"></a> [tenancy\_id](#output\_tenancy\_id) | The ID of the tenancy |
| <a name="output_tenancy_name"></a> [tenancy\_name](#output\_tenancy\_name) | The name of the tenancy |
| <a name="output_vcn_cidr_blocks"></a> [vcn\_cidr\_blocks](#output\_vcn\_cidr\_blocks) | The CIDR block for the VCN |
| <a name="output_vcn_ipv6_cidr_blocks"></a> [vcn\_ipv6\_cidr\_blocks](#output\_vcn\_ipv6\_cidr\_blocks) | The IPv6 CIDR block for the VCN |
| <a name="output_vcn_ipv6_cidr_private_blocks"></a> [vcn\_ipv6\_cidr\_private\_blocks](#output\_vcn\_ipv6\_cidr\_private\_blocks) | The IPv6 CIDR block for the VCN |
<!-- END_TF_DOCS -->
