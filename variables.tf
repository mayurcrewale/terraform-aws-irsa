variable "role_name" {
  description = "Name of the IAM role to create for the Kubernetes service account."
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the EKS cluster's IAM OIDC provider (from the eks-cluster module)."
  type        = string
}

variable "oidc_provider_url" {
  description = "OIDC provider URL without the https:// prefix (from the eks-cluster module)."
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace of the service account."
  type        = string
}

variable "service_account_name" {
  description = "Name of the Kubernetes service account this role is bound to."
  type        = string
}

variable "policy_arns" {
  description = "Existing managed IAM policy ARNs to attach to the role."
  type        = list(string)
  default     = []
}

variable "inline_policy_json" {
  description = "Optional inline IAM policy document (JSON) to attach to the role."
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
