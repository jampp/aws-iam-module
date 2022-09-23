variable "name" {
  type        = string
  description = "Name of IAM role"
}

variable "description" {
  type        = string
  default     = ""
  description = "IAM Role description"
}

variable "path" {
  type        = string
  default     = "/"
  description = "Path of IAM role"
}

variable "permissions_boundary_arn" {
  type        = string
  default     = ""
  description = "Permissions boundary ARN to use for IAM role"
}

variable "cluster_service_accounts" {
  type        = map(list(string))
  description = "EKS cluster and k8s ServiceAccount pairs. Each EKS cluster can have multiple k8s ServiceAccount."
}

variable "max_session_duration" {
  type        = number
  default     = 43200
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
}

variable "policy_arns" {
  type        = map(string)
  default     = {}
  description = "ARNs of any policies to attach to the IAM role"
}

variable "policies" {
  type        = any
  description = "Policies to create and attach to the IAM role"
  default     = {}
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to add the the IAM role"
}
