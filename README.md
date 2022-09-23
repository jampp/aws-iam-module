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

  create_instance_profile = true

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
| create_instance_profile | Controls whether the instance profile is created. | boolean | `false` | no |
| assume_role_policy_file | Tempalte file with the policy that grants an entity permission to assume the role. | string | `null` | yes |
| assume_role_policy_vars | Variables to inject into `assume_role_policy_file` | `map(any)` | `{}` | no |
| inline_policies | Map defining an exclusive set of IAM inline policies associated with the IAM role. | `map(any)` | `{}` | no |
| tags | Tags for all resources managed by this module | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The ARN of the Role. |
| instance_profile_arn | The ARN of the instance profile. |


#### EKS Role with policies
```hcl
module "eks_role_with_policies" {
  source = "git::git@github.com:jampp/terraform-iam-module.git//modules/eks-role-with-policies?ref=<version>"

  name        = "my-iam-role"
  description = "Example IAM role"
  path        = "/"

  cluster_service_accounts = {
    "example-eks-cluster" = ["namespace:sa-name"]
  }

  policy_arns = {
    "example-policy"   = "arn:aws:iam::111111111111:policy/example-policy",
    "example-policy-2" = "arn:aws:iam::111111111111:policy/example-policy-2"
  }

  policies = {
    "my-policy" = {
      description = "New policy description"
      statements = [
        {
          actions = [
            "ec2:DescribeImages",
            "ec2:DescribeInstances",
          ]

          resources = ["*"]
          principals = [
            {
              type        = "Service"
              identifiers = ["ec2.amazonaws.com"]
            }
          ]

          conditions = [
            {
              test     = "StringEquals"
              variable = "ec2:ResourceTag/test"
              values   = ["test"]
            }
          ]
        }
      ]
    },
  }

  tags = {
    Example = "value"
  }

}
```

## Examples
- [Complete EKS role with policies](https://github.com/jampp/terraform-aws-iam-module/tree/main/examples/eks-role-with-policies)

## Requirements

| Name | Version |
|------|---------|
| [terraform](#requirement\_terraform) | >= 1.0.0 |
| [aws](#requirement\_aws) | >= 4.0 |

## Providers

| Name | Version |
|------|---------|
| [aws](#provider\_aws) | >= 4.0 |

## Modules

| Name | Version |
|------|---------|
| [iam-eks-role](https://github.com/terraform-aws-modules/terraform-aws-iam/tree/master/modules/iam-eks-role) | == 5.3.0 |

## Resources
| Name | Type |
|------|------|
| [aws_iam_policy_document.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy.policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |

## Inputs
| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-------:|:--------:|
| name | Name of IAM role | `string` | `null` | yes |
| description | IAM Role description | `string` | `""` | no |
| path | Path of IAM role | `string` | `/` | no |
| permissions_boundary_arn | Permissions boundary ARN to use for IAM role | `string` | `null` | no |
| cluster_service_accounts | EKS cluster and k8s ServiceAccount pairs. Each EKS cluster can have multiple k8s ServiceAccount. | `map(list(string))` | `{}` | yes |
| max_session_duration | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `43200` | no |
| policy_arns | ARNs of any policies to attach to the IAM role | `map(string)` | `{}` | no |
| policies | Policies to create and attach to the IAM role | `any` | `{}` | no |
| tags | A map of tags to add the the IAM role | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| policy_arns | The ARN of the created policies. |
| role_arn | The ARN of the role. |
