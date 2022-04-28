variable "subnet_ids" {
  type = list(any)
}

variable "cluster_name" {}
variable "role_eks" {}
variable "tags" {
  type = map(any)
}
variable "security_group_ids" {
  type = list(any)
}
variable "encryption_config_kms_arn" {}
variable "eks_version" {}
variable "endpoint_public_access" {
  default = true
}
variable "public_access_cidrs" {}
