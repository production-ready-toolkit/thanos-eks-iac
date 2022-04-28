variable "node_group_name" {}
variable "node_role_arn" {}
variable "cluster_name" {}
variable "eks_version" {}
variable "security_groups" {
  type = list(string)
}
variable "subnet_ids" {
  type = list(string)
}
variable "instance_type" {
  default = "t2.medium"
}
variable "labels" {
  type = map(string)
}
variable "capacity_type" {
  default = "on-demand"
}
variable "desired_size" {
  default = 1
}
variable "min_size" {
  default = 1
}
variable "max_size" {
  default = 1
}
variable "cluster_certificate_autority" {}
variable "cluster_endpoint" {}
variable "tags" {
  type = map(string)
}
variable "disk_size" {
  default = 20
}
