provider "aws" {
  region = "us-east-1"
}

module "eks_role_with_policies" {
  source = "../../modules/eks-role-with-policies"

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
