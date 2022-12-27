variable "role_name" {
  type        = string
  description = "(required) Role name"
}

variable "role_path" {
  type        = string
  default     = "/"
  description = "(optional, default: /) Role path"
}

variable "description" {
  type        = string
  description = "Description of the role."
  default     = ""
}

variable "create_instance_profile" {
  type        = bool
  default     = false
  description = "(optional, default: false) Controls whether the instance profile is created"
}

variable "assume_role_policy_file" {
  type        = string
  description = "(required) Role name"
}

variable "assume_role_policy_vars" {
  type        = map(any)
  default     = {}
  description = "(optional, default: {}) Role name"
}

variable "inline_policies" {
  type = map(object({
    file = string
    vars = map(any)
  }))
  default     = {}
  description = "(optional, default: {}) Inline policies"
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role. If this attribute is not configured, Terraform will ignore policy attachments to this resource."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "(optional)"
  default     = {}
}
