data "aws_ssm_parameter" "golden_ami" {
  name = "/url/to/goldenimage/${var.eks_version}/latest"
}


data "template_file" "user_data" {
  template = file("$(path.module)/files/userdata/userdata.sh.tpl")
  vars = {
    cluster_name           = var.cluster_name
    cluster_endpoint       = var.cluster_endpoint
    cluster_ca_certificate = var.cluster_ca_certificate_authority
    bootstrap_extra_args   = ""
    kubelet_extra_args     = ""
  }
}
