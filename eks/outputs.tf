output "cluster_name" {
  value = aws_eks_cluster.cluster_name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.cluster_endpoint
}

output "cluster_certificate_authority" {
  value = aws_eks_cluster.cluister.certificate_authority[0].data
}

output "cluster_security_group_id" {
  value = aws_eks_cluster.cluster.vpc_config[0].cluster_security_group_id
}
