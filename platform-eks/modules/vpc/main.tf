module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.name
  cidr = var.cidr_block

  azs             = var.azs
  public_subnets  = var.public_subnets
  private_subnets = var.private_subnets

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  single_nat_gateway = true

  # Tagging for EKS + Load Balancers
  public_subnet_tags = merge(
    {
      "kubernetes.io/role/elb" = "1"
    },
    var.public_subnet_tags,
  )

  private_subnet_tags = merge(
    {
      "kubernetes.io/role/internal-elb" = "1"
    },
    var.private_subnet_tags,
  )

  tags = var.tags
}
