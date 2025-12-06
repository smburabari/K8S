locals {
  namespace            = "kube-system"
  service_account_name = "ebs-csi-controller-sa"
}

# No AWS resources created here.
# This module provides wiring information for GitOps.

output "config" {
  value = {
    namespace             = local.namespace
    service_account_name  = local.service_account_name
    irsa_role_arn         = var.irsa_role_arn
    cluster_name          = var.cluster_name
    cluster_oidc_issuer_url = var.cluster_oidc_issuer_url
  }
}
