##############################
# Cluster identifiers
##############################
variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_oidc_issuer_url" {
  description = "OIDC issuer URL for IRSA validation"
  type        = string
}


##############################
# IRSA Role ARNs
##############################
variable "irsa_ebs_csi_role_arn" {
  description = "IRSA role ARN for EBS CSI"
  type        = string
}



##############################
# Tags
##############################
variable "tags" {
  description = "Common tags to apply"
  type        = map(string)
  default     = {}
}
