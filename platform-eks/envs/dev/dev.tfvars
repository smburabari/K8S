region = "us-east-1"

# VPC settings
vpc_name = "platform-eks-dev01"
vpc_cidr = "10.0.0.0/16"

azs = [
  "us-east-1a",
  "us-east-1b",
  "us-east-1c",
]

public_subnets = [
  "10.0.0.0/24",
  "10.0.1.0/24",
  "10.0.2.0/24",
]

private_subnets = [
  "10.0.10.0/24",
  "10.0.11.0/24",
  "10.0.12.0/24",
]

public_subnet_tags = {}

private_subnet_tags = {}

tags = {
  Environment = "dev"
  Project     = "platform-eks-dev01"
}

# EKS settings
cluster_name    = "platform-eks-dev01"
cluster_version = "1.29"

node_instance_types = ["t3.small"]
node_desired_size   = 4
node_min_size       = 1
node_max_size       = 8

cluster_endpoint_public_access = true
create_kms_key                 = true


