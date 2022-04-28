resource "aws_launch_template" "eks_node_group" {
  name                   = format("%s-node-group", "${var.cluster_name}-${var.node_group_name}")
  update_default_version = true

  image_id      = data.aws_ssm_parameter.eks_ami.value
  instance_type = var.instance_type
  user_data     = base64encode(data.template_file.user_data.rendered)

  network_interfaces {
    associate_public_ip_address = false
    delete_on_termination       = true
    security_groups             = var.security_groups
  }

  monitoring {
    enabled = true
  }

  ebs_optimized = true

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = var.node_volume_size
      volume_type           = "gp2"
      encrypted             = true
      delete_on_termination = true
    }
  }
  tag_specification {
    resource_type = "instance"

    tags = merge({
      Name = format("%s-node-group", "${var.cluster_name}-${var.node_group_name}")
    }, var.tags)
  }

  lifecycle {
    create_before_destroy = true
  }
}

