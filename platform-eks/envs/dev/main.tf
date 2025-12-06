module "vpc" {
  source = "../../modules/vpc"

  name = var.vpc_name
  cidr_block = var.vpc_cidr

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  public_subnet_tags  = var.public_subnet_tags
  private_subnet_tags = var.private_subnet_tags

  tags = var.tags
}

module "eks" {
  source = "../../modules/eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets

  node_instance_types = var.node_instance_types
  node_desired_size   = var.node_desired_size
  node_min_size       = var.node_min_size
  node_max_size       = var.node_max_size

  cluster_endpoint_public_access = var.cluster_endpoint_public_access

  create_kms_key = var.create_kms_key

  tags = var.tags
}

module "irsa_ebs_csi" {
  source = "../../modules/irsa"

  role_name               = "${var.cluster_name}-ebs-csi"
  namespace               = "kube-system"
  service_account_name    = "ebs-csi-controller-sa"

  oidc_provider_arn       = module.eks.oidc_provider_arn
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url

  policy_json        = file("${path.module}/policies/ebs-csi-controller-policy.json")
  policy_description = "IRSA policy for EBS CSI controller"

  tags = var.tags
}

module "irsa_aws_lb" {
  source = "../../modules/irsa"

  role_name            = "${var.cluster_name}-aws-lb-controller"
  namespace            = "kube-system"
  service_account_name = "aws-load-balancer-controller"

  oidc_provider_arn       = module.eks.oidc_provider_arn
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url

  policy_json        = file("${path.module}/policies/aws-lb-controller-policy.json")
  policy_description = "IRSA policy for AWS Load Balancer Controller"

  tags = var.tags
}

module "irsa_external_dns" {
  source = "../../modules/irsa"

  role_name            = "${var.cluster_name}-external-dns"
  namespace            = "kube-system"
  service_account_name = "external-dns"

  oidc_provider_arn       = module.eks.oidc_provider_arn
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url

  policy_json        = file("${path.module}/policies/external-dns-policy.json")
  policy_description = "IRSA policy for ExternalDNS"

  tags = var.tags
}

module "irsa_karpenter" {
  source = "../../modules/irsa"

  role_name            = "${var.cluster_name}-karpenter"
  namespace            = "karpenter"
  service_account_name = "karpenter"

  oidc_provider_arn       = module.eks.oidc_provider_arn
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url

  policy_json        = file("${path.module}/policies/karpenter-controller-policy.json")
  policy_description = "IRSA policy for Karpenter controller"

  tags = var.tags
}

module "addons" {
  source = "../../modules/addons"

  cluster_name            = module.eks.cluster_name
  cluster_oidc_issuer_url = module.eks.cluster_oidc_issuer_url

  # IRSA role ARNs
  irsa_ebs_csi_role_arn       = module.irsa_ebs_csi.iam_role_arn
  
  

  tags = var.tags
}
