// security group cluster for cluster and node
resource "aws_security_group" "eks_cluster_metrics_prod" {
    name        = "eks_cluster_metrics_prod"
    description = "Security Group for redis cluster"
    vpc_id      = var.vpc_id["prod"]

    tags = {
        Name = "eks_cluster_metrics_prod"
    }
}

resource "aws_security_group_rule" "cluster_egress_internet_prod" {
    description = "Allow egress for redis cluster"
    protocol    = "-1"
    security_group_id = aws_security_group.eks_cluster_metrics_prod.id
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    type       = "egress"
}

resource "aws_security_group_rule" "cluster_https_worker_ingress_prod" {
    description = "Allow ingress for redis cluster"
    protocol    = "tcp"
    security_group_id = aws_security_group.eks_cluster_metrics_prod.id
    source_security_group_id = aws_security_group.eks_node_metrics_prod.id
    from_port   = 433
    to_port     = 433
    type       = "ingress"
}

resource "aws_security_group_rule" "cluster_https_subnets_private_prod" {
    description = "Allow ingress for redis cluster"
    protocol    = "tcp"
    security_group_id = aws_security_group.eks_cluster_metrics_prod.id
    source_security_group_id = aws_security_group.eks_node_metrics_prod.id
    from_port   = 433
    to_port     = 433
    type       = "ingress"
}


resource "aws_security_group_rule" "core_dns_tcp_subnets_private_prod" {
    description = "Allow core dns subnets private"
    protocol    = "tcp"
    security_group_id = aws_security_group.eks_cluster_metrics_prod.id
    cidr_blocks = var.cidr_blocks["prod"]
    from_port   = 53
    to_port     = 53
    type       = "ingress"
}

resource "aws_security_group_rule" "core_dns_udp_subnets_private_prod" {
    description = "Allow cluster https subnets private"
    protocol    = "udp"
    security_group_id = aws_security_group.eks_cluster_metrics_prod.id
    cidr_blocks = var.cidr_blocks["prod"]
    from_port   = 53
    to_port     = 53
    type       = "ingress"
}


resource "aws_security_group_rule" "sg_default_https_allow_cluster" {
    description = "sg_default_https_allow_cluster"
    protocol    = "tcp"
    security_group_id = var.sg_vpc_default["prod"]
    source_security_group_id = aws_security_group.eks_node_metrics_prod.id
    from_port   = 443
    to_port     = 443
    type       = "ingress"
}

resource "aws_security_group" "eks_node_metrics_prod" {
    name = "eks_node_metrics_prod"
    description = "eks_node_metrics_prod"
    vpc_id = var.vpc_id["prod"]

    tags = {
        Name = "eks_node_metrics_prod"
    }

}

resource "aws_security_group_rule" "workers_egress_internet_prod" {
    description = "Allow nodes all egress to the Internet"
    protocol    = "-1"
    security_group_id = aws_security_group.eks_node_metrics_prod.id
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    type       = "egress"
}

resource "aws_security_group_rule" "workers_ingress_cluster_kubelet_prod" {
    description = "Allow workers Kubelets to receive communication from the cluster control plane"
    protocol    = "tcp"
    security_group_id = aws_security_group.eks_node_metrics_prod.id
    source_security_group_id = aws_security_group.eks_cluster_metrics_prod.id
    from_port   = 10250
    to_port     = 10250
    type       = "ingress"
}

resource "aws_security_group_rule" "workers_ingress_cluster_https_prod" {
    description = "Allow pods running extension API servers on port 443 to receive communication from cluter control plane"
    protocol    = "tcp"
    security_group_id = aws_security_group.eks_node_metrics_prod.id
    source_security_group_id = aws_security_group.eks_cluster_metrics_prod.id
    from_port   = 443
    to_port     = 443
    type       = "ingress"
}

resource "aws_security_group_rule" "workers_ingress_https_subnets_private_prod" {
    description = "Allow workers_ingress https subnets private"
    protocol    = "tcp"
    security_group_id = aws_security_group.eks_node_metrics_prod.id
    cidr_blocks = var.cidr_blocks["prod"]
    from_port   = 443
    to_port     = 443
    type       = "ingress"
}

resource "aws_security_group_rule" "workers_self_prod" {
    description = "Allow inter-node communication"
    protocol    = "-1"
    self = true
    security_group_id = aws_security_group.eks_node_metrics_prod.id
    from_port   = 0
    to_port     = 0
    type       = "ingress"
}

resource "aws_security_group_rule" "workers_controle_plane_prod" {
    description = "Allow recommended traffig control plane"
    protocol    = "tcp"
    security_group_id = aws_security_group.eks_node_metrics_prod.id
    source_security_group_id = aws_security_group.eks_cluster_metrics_prod.id
    from_port   = 1025
    to_port     = 65535
    type       = "ingress"
}

resource "aws_security_group_rule" "cluster_primary_ingress_workers_prod" {
    description = "Allow pods running on workers to send communication to cluster primary security group (e.g Fargate pods)"
    protocol    = "tcp"
    security_group_id = aws_security_group.eks_node_metrics_prod.id
    source_security_group_id = aws_security_group.eks_cluster_metrics_prod.id
    from_port   = 10250
    to_port     = 10250
    type       = "ingress"
}

resource "aws_security_group_rule" "sg_default_https_allow_node_prod" {
    description = "sg_default_https_allow_node_prod"
    protocol    = "tcp"
    security_group_id = var.sg_vpc_default["prod"]
    source_security_group_id = aws_security_group.eks_cluster_metrics_prod.id
    from_port   = 443
    to_port     = 443
    type       = "ingress"
}