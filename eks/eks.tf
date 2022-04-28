resource "aws_eks_cluster" "cluster" {
  name     = var.cluster_name
  role_arn = var.role_eks
  version  = var.eks_version
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler",
  ]

  vpc_config {
    subnet_ids              = var.subnet_ids
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
    public_access_cidrs     = var.public_access_cidrs
    security_group_ids      = var.security_group_ids
  }

  tags = merge({
    Name = var.cluster_name
  }, var.tags)

  encryption_config {
    provider {
      key_arn = var.encryption_config_kms_arn
    }
    resources = [
      "secrets"
    ]
  }
}
