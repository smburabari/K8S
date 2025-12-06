variable "irsa_role_arn" {
  description = "IAM role ARN for the EBS CSI controller IRSA"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "EKS cluster OIDC issuer URL"
  type        = string
}

variable "tags" {
  description = "Tags to apply to any resources (if added later)"
  type        = map(string)
  default     = {}
}
