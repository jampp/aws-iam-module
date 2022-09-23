provider "aws" {
  region = "us-east-1"
}

module "inline_complete" {
  source = "../../modules/inline-role"

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
