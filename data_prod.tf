data "aws_eks_cluster" "cluster_prod" {
  name = module.k8s_metrics_prod.cluster_name
}

data "aws_eks_cluster_auth" "cluster_prod" {
  name = module.k8s_metrics_prod.cluster_name
}
