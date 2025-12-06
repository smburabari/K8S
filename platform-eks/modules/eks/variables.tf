variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for the cluster"
  type        = list(string)
}

variable "node_instance_types" {
  description = "EC2 instance types for the managed node group"
  type        = list(string)
}

variable "node_desired_size" {
  description = "Desired number of nodes in the managed node group"
  type        = number
}

variable "node_min_size" {
  description = "Minimum number of nodes in the managed node group"
  type        = number
}

variable "node_max_size" {
  description = "Maximum number of nodes in the managed node group"
  type        = number
}

variable "cluster_endpoint_public_access" {
  description = "Whether the EKS API should be publicly accessible"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to all EKS resources"
  type        = map(string)
  default     = {}
}
variable "create_kms_key" {
  description = "Whether to create a KMS key for secret encryption"
  type        = bool
  default     = true
}
