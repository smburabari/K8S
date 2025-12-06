##############################################
# EBS CSI Addon
##############################################
module "ebs_csi" {
  source = "./ebs_csi"

  irsa_role_arn           = var.irsa_ebs_csi_role_arn
  cluster_name            = var.cluster_name
  cluster_oidc_issuer_url = var.cluster_oidc_issuer_url

  tags = var.tags
}
