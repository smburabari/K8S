variable "environment" {
  description = "Environment name (dev, uat, prod)"
  type        = string
}

variable "region" {
  description = "AWS region for backend resources"
  type        = string
}

variable "bucket_name_prefix" {
  description = "Prefix for the Terraform state S3 bucket"
  type        = string
}

variable "table_name_prefix" {
  description = "Prefix for the DynamoDB lock table"
  type        = string
}
