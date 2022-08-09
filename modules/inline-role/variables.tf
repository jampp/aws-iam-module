variable "role_name" {
  type        = string
  description = "(required) Role name"
}

variable "role_path" {
  type        = string
  default     = "/"
  description = "(optional, default: /) Role path"
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

variable "tags" {
  type        = map(string)
  description = "(optional)"
  default     = {}
}
