module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnet_ids

  enable_irsa = true

  # Enable KMS encryption for Kubernetes Secrets
  create_kms_key = var.create_kms_key

cluster_encryption_config = {
  resources = ["secrets"]
}

  eks_managed_node_groups = {
    default = {
      instance_types = var.node_instance_types
      desired_size   = var.node_desired_size
      min_size       = var.node_min_size
      max_size       = var.node_max_size
    }
  }

  cluster_endpoint_public_access = var.cluster_endpoint_public_access

  tags = var.tags
}
