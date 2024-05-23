<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.8.0 |
| <a name="requirement_oci"></a> [oci](#requirement\_oci) | ~> 5.42.0 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_oci"></a> [oci](#provider\_oci) | 5.42.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.5 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [oci_identity_api_key.admin](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_api_key) | resource |
| [oci_identity_auth_token.admin](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_auth_token) | resource |
| [oci_identity_compartment.compartment](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_compartment) | resource |
| [oci_identity_customer_secret_key.admin](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_customer_secret_key) | resource |
| [oci_identity_group.administrators](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_group) | resource |
| [oci_identity_policy.administrators](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_policy) | resource |
| [oci_identity_ui_password.admin_initial](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_ui_password) | resource |
| [oci_identity_user.admin](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_user) | resource |
| [oci_identity_user_group_membership.admin](https://registry.terraform.io/providers/oracle/oci/latest/docs/resources/identity_user_group_membership) | resource |
| [tls_private_key.admin_api_key](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [oci_identity_tenancy.tenancy](https://registry.terraform.io/providers/oracle/oci/latest/docs/data-sources/identity_tenancy) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_oci_region"></a> [oci\_region](#input\_oci\_region) | The region for the OCI provider | `string` | n/a | yes |
| <a name="input_tenancy_id"></a> [tenancy\_id](#input\_tenancy\_id) | The OCID of the tenancy | `string` | n/a | yes |
| <a name="input_admin_create_credentials"></a> [admin\_create\_credentials](#input\_admin\_create\_credentials) | Types of credentials to create for the admin user | <pre>object({<br>    api_key      = bool<br>    auth_token   = bool<br>    customer_key = bool<br>    password     = bool<br>  })</pre> | <pre>{<br>  "api_key": true,<br>  "auth_token": false,<br>  "customer_key": false,<br>  "password": false<br>}</pre> | no |
| <a name="input_iac_project_name"></a> [iac\_project\_name](#input\_iac\_project\_name) | The name of the iac project | `string` | `"oci-free"` | no |
| <a name="input_iac_project_source"></a> [iac\_project\_source](#input\_iac\_project\_source) | The source repo of the iac project | `string` | `"https://git.bdeshi.space/bdeshi/terraform-oci-free.git"` | no |
| <a name="input_oci_profile"></a> [oci\_profile](#input\_oci\_profile) | The config file profile for the OCI provider | `string` | `null` | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | Name prefix for all resources | `string` | `"free-"` | no |

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
| <a name="output_tenancy_id"></a> [tenancy\_id](#output\_tenancy\_id) | The ID of the tenancy |
| <a name="output_tenancy_name"></a> [tenancy\_name](#output\_tenancy\_name) | The name of the tenancy |
<!-- END_TF_DOCS -->