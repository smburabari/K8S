variable "role_name" {
  description = "Name of the IAM role to create for this service account"
  type        = string
}

variable "namespace" {
  description = "Kubernetes namespace of the service account"
  type        = string
}

variable "service_account_name" {
  description = "Kubernetes service account name"
  type        = string
}

variable "oidc_provider_arn" {
  description = "ARN of the EKS OIDC provider (from module.eks.oidc_provider_arn)"
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "EKS cluster OIDC issuer URL (from module.eks.cluster_oidc_issuer_url)"
  type        = string
}

variable "policy_json" {
  description = "IAM policy JSON to attach to this role"
  type        = string
}

variable "policy_description" {
  description = "Description for the IAM policy"
  type        = string
  default     = "IRSA policy for Kubernetes service account"
}

variable "tags" {
  description = "Tags to apply to IAM resources"
  type        = map(string)
  default     = {}
}
