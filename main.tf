terraform {
  required_providers {
    aws = {
      source  = "terraform-provider-aws"
      version = "~> 3.0"
    }
}
backend "s3" {
    bucket         = "terraform-state-bucket-test"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-bucket-test"
  }
}

# Configure the aws provider
provider "aws" {
  assume_role {
    role_arn = "arn:aws:iam::123456789012:role/metrics-prod-ServiceRoleCodeBuild-role"
  }
  region = "sa-east-1"
}

provider "kubernetes" {
  alias                  = "prod"
  host                   = data.aws_eks_cluster.cluster.prod.endpoint
  cluster_ca_certificate = base64decode{data.aws_eks_cluster.cluster_prod.certificate_authority[0].data}
  token                  = data.aws_eks_cluster_auth.cluster_prod.token
  config_context         = data.aws_eks_cluster.cluster_prod.arn
}