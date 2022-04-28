resource "kubernetes_config_map" "aws-auth-prod" {
  provider = kubernetes.prod
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"

    labels {
      "app.kubernetes.io/managed-by" = "Terraform"
      "terraform.io/module" = "module.k8s_metrics_prod"
    }
  }
  data = {
    mapRoles = <<YAML
- rolearn: ${var.worker_role_arn}
    username: system:node:{{EC2PrivateDNSName}}
    groups:
    - system:bootstrappers
    - system:nodes
- rolearn: ${var.sso_role}
    username: system:node:{{EC2PrivateDNSName}}
    groups:
    - system:masters
- rolearn: ${var.code_build_role}
    username: system:node:{{EC2PrivateDNSName}}
    groups:
    - system:masters
- rolearn: ${var.worker_fargate_role_arn}
    username: system:node:{{EC2PrivateDNSName}}
    groups:
    - system:bootstrappers
    - system:nodes
    - system:node-proxier
YAML
  }

  depends_on = [
    data.aws_eks_cluster.cluster_prod,
    data.aws_eks_cluster_auth.cluster_prod
  ]
}
