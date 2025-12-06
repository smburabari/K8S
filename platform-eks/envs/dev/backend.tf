terraform {
  backend "s3" {
    bucket         = "platform-eks-dev01-tfstate-dev"
    key            = "envs/dev/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "platform-eks-dev01-tflock-dev"
    encrypt        = true
  }
}
