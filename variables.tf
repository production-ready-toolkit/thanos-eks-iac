variable "role_eks" {
  default = "arn:aws:iam::1234567890:role/custom_metrics_prod_eksCluster_role"
}

variable "encryption_kms_arn" {
  default = "arn:aws:kms-sa-east-1:1234567890:key/xxxxxxxx-xxxx-xxxx-xxxxx-xxxxxx"
}
variable "code_build_role" {
  default = "arn:aws:iam::1234567890:role/metrics_prod_ServiceRoleCodeBuild-role"
}
variable "subnet_ids" {
  type = map
  default = {
    prod = ["subnet-1234567890", "subnet-0987654321"]
  }
}

variable "subnet_ids_nodes" {
  type = map
  default = {
    prod = ["subnet-1234567890", "subnet-0987654321"]
  }
}

variable "subnet_ids_nodes_azs" {
  type = map
  default = {
    prod-a = ["subnet-1234567890", "subnet-0987654321"]
    prod-b = ["subnet-1234567890", "subnet-0987654321"]
    prod-c = ["subnet-1234567890", "subnet-0987654321"]
  }
}
variable "cidr_blocks" {
  type   = map 
  default = {
    prod = ["200.9.199.0/24"]
  }
}

variable public_access_cidrs {
  type = list 
  default = {
    "200.9.199.0/24"
  }
}

variable "worker_role_arn" {
  default = "arn:aws:iam::1234567890:role/custom_metrics_prod_EksWorkerNode_role"
}
variable "worker_fargate_role_arn" {
  default = "arn:aws:iam::1234567890:role/custom_services_eks_role"
}
variable "sso_role" {
  default = "arn:aws:iam::1234567890:role/AWSReservedSSO_IU_METRICS_PWR_xxxxxxxxxxxx"
}
variable "vpc_id" {
  type = map
  default = {
    prod = "sg-xpto1234567890"
  }
}

variable "tags" {
  type = map
  default = {
    Name = ""
  }
}
