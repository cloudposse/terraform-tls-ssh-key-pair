## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.0 |
| local | ~> 1.3 |
| null | ~> 2.1 |
| tls | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| local | ~> 1.3 |
| null | ~> 2.1 |
| tls | ~> 2.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| attributes | Additional attributes (e.g. `1`) | `list(string)` | `[]` | no |
| chmod\_command | Template of the command executed on the private key file | `string` | `"chmod 600 %v"` | no |
| delimiter | Delimiter to be used between `namespace`, `stage`, `name` and `attributes` | `string` | `"-"` | no |
| name | Application or solution name (e.g. `app`) | `string` | n/a | yes |
| namespace | Namespace (e.g. `eg` or `cp`) | `string` | `""` | no |
| private\_key\_extension | Private key extension | `string` | `""` | no |
| public\_key\_extension | Public key extension | `string` | `".pub"` | no |
| ssh\_key\_algorithm | SSH key algorithm | `string` | `"RSA"` | no |
| ssh\_public\_key\_path | Path to SSH public key directory (e.g. `/secrets`) | `string` | n/a | yes |
| stage | Stage (e.g. `prod`, `dev`, `staging`) | `string` | `""` | no |
| tags | Additional tags (e.g. map(`BusinessUnit`,`XYZ`) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| key\_name | Name of SSH key |
| public\_key | Content of the generated public key |

