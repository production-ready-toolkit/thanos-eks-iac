// cluster env
module "k8s_metrics_prod" {
  source                    = "./modules/eks"
  cluster_name              = "eks_metrics_prod"
  eks_version               = "1.19" 
  subnet_ids                = var.subnet_ids["prod"]
  endpoint_private_access   = true
  endpoint_public_access    = true
  public_access_cidrs       = var.public_access_cidrs
  role_eks                  = var.role_eks
  encryption_config_kms_arn = var.encryption_kms_arn
  security_group_ids        = ["${aws_security_group.eks_cluster_metrics_prod.id}"]
  tags                      = var.tags
}

// node prod workload general
module "k8s_metrics_prod_node_general" {
  source                       = "./modules/eks-worker-nodes"
  cluster_name                 = module.k8s_metrics_prod.cluster_name
  eks_version                  = "1.19"  
  cluster_endpoint             = module.k8s_metrics_prod.cluster_endpoint
  cluster_certificate_autority = module.k8s_metrics_prod.cluster_certificate_autority
  node_group_name              = "general"
  node_role_arn                = var.node_role_arn
  security_groups              = ["${aws_security_group.eks_cluster_metrics_prod.id}","${module.k8s_metrics_prod.cluster_security_group_id}","${aws_security_group.eks_node_metrics_prod.id}"]
  subnet_ids                   = var.subnet_ids_nodes["prod"]
  instance_type                = "m5.xlarge"
  disk_size                    = 100
  labels                       = {
    workload = "general"
  }
  capacity_type                = "ON_DEMAND"
  desired_size                 = 4
  min_size                     = 4
  max_size                     = 4
  tags                         = var.tags
  depends_on = [
    module.k8s_metrics_env,
    kubernetes_config_map.aws_auth_prod
  ]
}

// node workload thanos query
module "k8s_metrics_prod_node_thanos_query_shared" {
  source                       = "./modules/eks-worker-nodes"
  cluster_name                 = module.k8s_metrics_prod.cluster_name
  eks_version                  = "1.19"
  cluster_endpoint             = module.k8s_metrics_prod.cluster_endpoint
  cluster_certificate_autority = module.k8s_metrics_prod.cluster_certificate_autority
  node_group_name              = "thanos-query-shared"
  node_role_arn                = var.node_role_arn
  security_groups              = ["${aws_security_group.eks_cluster_metrics_prod.id}","${module.k8s_metrics_prod.cluster_security_group_id}","${aws_security_group.eks_node_metrics_prod.id}"]
  subnet_ids                   = var.subnet_ids_nodes["prod"]
  instance_type                = "m5.xlarge"
  disk_size                    = 100
  labels                       = {
    workload = "thanos-query-shared"
  }
  capacity_type                = "ON_DEMAND"
  desired_size                 = 6
  min_size                     = 6
  max_size                     = 20
  tags                         = var.tags
  depends_on = [
    module.k8s_metrics_prod,
    kubernetes_config_map.aws_auth_env
  ]
}

// node env workload thanos receive and store shared AZ-A
 module "k8s_metrics_prod_node_thanos_receive_shared_az_a" {
  source                       = "./modules/eks-worker-nodes"
  cluster_name                 = module.k8s_metrics_prod.cluster_name
  eks_version                  = "1.19"
  cluster_endpoint             = module.k8s_metrics_prod.cluster_endpoint
  cluster_certificate_autority = module.k8s_metrics_prod.cluster_certificate_autority
  node_group_name              = "thanos-receive-shared-az-a"
  node_role_arn                = var.node_role_arn
  security_groups              = ["${aws_security_group.eks_cluster_metrics_prod.id}","${module.k8s_metrics_prod.cluster_security_group_id}","${aws_security_group.eks_node_metrics_prod.id}"]
  subnet_ids                   = var.subnet_ids_nodes["prod-a"]
  instance_type                = "m5.2xlarge"
  disk_size                    = 700
  labels                       = {
    workload = "thanos-receive-shared"
  }
  capacity_type                = "ON_DEMAND"
  desired_size                 = 13
  min_size                     = 13
  max_size                     = 100
  tags                         = var.tags
  depends_on = [
    module.k8s-metrics-prod,
    kubernetes_config_map.aws_auth_prod
  ]
}

// node env workload thanos receive and store shared AZ-B
 module "k8s_metrics_prod_node_thanos_receive_shared_az_b" {
  source                       = "./modules/eks-worker-nodes"
  cluster_name                 = module.k8s_metrics_prod.cluster_name
  eks_version                  = "1.19"
  cluster_endpoint             = module.k8s_metrics_prod.cluster_endpoint
  cluster_certificate_autority = module.k8s_metrics_prod.cluster_certificate_autority
  node_group_name              = "thanos-receive-shared-az-b"
  node_role_arn                = var.node_role_arn
  security_groups              = ["${aws_security_group.eks_cluster_metrics_prod.id}","${module.k8s_metrics_prod.cluster_security_group_id}","${aws_security_group.eks_node_metrics_prod.id}"]
  subnet_ids                   = var.subnet_ids_nodes["prod-b"]
  instance_type                = "m5.2xlarge"
  disk_size                    = 700
  labels                       = {
    workload = "thanos-receive-shared"
  }
  capacity_type                = "ON_DEMAND"
  desired_size                 = 13
  min_size                     = 13
  max_size                     = 100
  tags                         = var.tags
  depends_on = [
    module.k8s-metrics-prod,
    kubernetes_config_map.aws_auth_prod
  ]
}

// node env workload thanos receive and store shared AZ-C
 module "k8s_metrics_prod_node_thanos_receive_shared_az_c" {
  source                       = "./modules/eks-worker-nodes"
  cluster_name                 = module.k8s_metrics_prod.cluster_name
  eks_version                  = "1.19"
  cluster_endpoint             = module.k8s_metrics_prod.cluster_endpoint
  cluster_certificate_autority = module.k8s_metrics_prod.cluster_certificate_autority
  node_group_name              = "thanos-receive-shared-az-c"
  node_role_arn                = var.node_role_arn
  security_groups              = ["${aws_security_group.eks_cluster_metrics_prod.id}","${module.k8s_metrics_prod.cluster_security_group_id}","${aws_security_group.eks_node_metrics_prod.id}"]
  subnet_ids                   = var.subnet_ids_nodes["prod-c"]
  instance_type                = "m5.2xlarge"
  disk_size                    = 700
  labels                       = {
    workload = "thanos-receive-shared"
  }
  capacity_type                = "ON_DEMAND"
  desired_size                 = 13
  min_size                     = 13
  max_size                     = 100
  tags                         = var.tags
  depends_on = [
    module.k8s_metrics_prod,
    kubernetes_config_map.aws_auth_prod
  ]
}

// node env workload monitoring and store shared
module "k8s_metrics_prod_node_monitoring_shared" {
  source                       = "./modules/eks-worker-nodes"
  cluster_name                 = module.k8s_metrics_prod.cluster_name
  eks_version                  = "1.19"
  cluster_endpoint             = module.k8s_metrics_prod.cluster_endpoint
  cluster_certificate_autority = module.k8s_metrics_prod.cluster_certificate_autority
  node_group_name              = "monitoring"
  node_role_arn                = var.node_role_arn
  security_groups              = ["${aws_security_group.eks_cluster_metrics_prod.id}","${module.k8s_metrics_prod.cluster_security_group_id}","${aws_security_group.eks_node_metrics_prod.id}"]
  subnet_ids                   = var.subnet_ids_nodes["prod"]
  instance_type                = "r5.2xlarge"
  disk_size                    = 400
  labels                       = {
    workload = "monitoring"
  }
  capacity_type                = "ON_DEMAND"
  desired_size                 = 2
  min_size                     = 2
  max_size                     = 4
  tags                         = var.tags
  depends_on = [
    module.k8s_metrics_prod,
    kubernetes_config_map.aws_auth_prod
  ]
}

// node env workload Grafana and store shared
module "k8s_metrics_env_node_grafana_shared" {
  source                       = "./modules/eks-worker-nodes"
  cluster_name                 = module.k8s_metrics_prod.cluster_name
  eks_version                  = "1.19"
  cluster_endpoint             = module.k8s_metrics_prod.cluster_endpoint
  cluster_certificate_autority = module.k8s_metrics_prod.cluster_certificate_autority
  node_group_name              = "grafana"
  node_role_arn                = var.node_role_arn
  security_groups              = ["${aws_security_group.eks_cluster_metrics_prod.id}","${module.k8s_metrics_prod.cluster_security_group_id}","${aws_security_group.eks_node_metrics_prod.id}"]
  subnet_ids                   = var.subnet_ids_nodes["prod"]
  instance_type                = "t3a.large"
  disk_size                    = 20
  labels                       = {
    workload = "grafana"
  }
  capacity_type                = "ON_DEMAND"
  desired_size                 = 3
  min_size                     = 3
  max_size                     = 4
  tags                         = var.tags
  depends_on = [
    module.k8s_metrics_prod,
    kubernetes_config_map.aws_auth_prod
  ]
}