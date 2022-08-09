# AWS IAM Module

Terraform module for custom IAM resources.

## Managed resources

- IAM Role

## Usage

#### Inline role
```hcl
module "inline_role" {
  source = "git::git@github.com:jampp/terraform-iam-module.git?ref=<version>"

  role_name = "my-role"
  role_path = "/"

  assume_role_policy_file = "files/assume-policy.tpl"
  assume_role_policy_vars = {
    role_name = "my-role"
  }

  inline_policies = {
    "my-policy" = {
      file = "files/policy.tpl"
      vars = {
        bucket = "mybucket.example"
      }
    }
  }

  tags = {
    Example = "Value"
  }

}
```

## Examples
- [Complete Inline Role](https://github.com/jampp/terraform-aws-iam-module/tree/main/examples/inline-complete) - Role with inline policies

## Requirements

| Name | Version |
|------|---------|
| [terraform](#requirement\_terraform) | >= 1.0.0 |
| [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| [aws](#provider\_aws) | >= 4.0 |

## Resources
| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_role.iam_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| role_name | Friendly name of the role. If omitted, Terraform will assign a random, unique name | `string` | `""` | no |
| role_path | Path to the role. | string | `/` | no |
| assume_role_policy_file | Tempalte file with the policy that grants an entity permission to assume the role. | string | `null` | yes |
| assume_role_policy_vars | Variables to inject into `assume_role_policy_file` | `map(any)` | `{}` | no |
| inline_policies | Map defining an exclusive set of IAM inline policies associated with the IAM role. | `map(any)` | `{}` | no |
| tags | Tags for all resources managed by this module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the Role. |
