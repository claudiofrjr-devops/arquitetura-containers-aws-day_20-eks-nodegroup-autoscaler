resource "aws_launch_template" "custom" {
  name = var.project_name

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 30
      volume_type = "gp3"
    }
  }

  ebs_optimized = true

  monitoring {
    enabled = false
  }


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = format("%s-custom", var.project_name)
    }
  }

  user_data = base64encode(templatefile("${path.module}/files/user-data/user-data.tpl", {
    CLUSTER_NAME                     = aws_eks_cluster.main.name
    KUBERNETES_ENDPOINT              = aws_eks_cluster.main.endpoint
    KUBERNETES_CERTIFICATE_AUTHORITY = aws_eks_cluster.main.certificate_authority.0.data
  }))
}

resource "aws_eks_node_group" "custom" {

  cluster_name    = aws_eks_cluster.main.id
  node_group_name = format("%s-custom", aws_eks_cluster.main.id)

  node_role_arn = aws_iam_role.eks_nodes_role.arn

  instance_types = var.nodes_instance_sizes

  launch_template {
    id      = aws_launch_template.custom.id
    version = aws_launch_template.custom.latest_version
  }

  scaling_config {
    desired_size = lookup(var.auto_scale_option, "desired")
    max_size     = lookup(var.auto_scale_option, "max")
    min_size     = lookup(var.auto_scale_option, "min")
  }

  subnet_ids = data.aws_ssm_parameter.pod_subnets[*].value

  capacity_type = "ON_DEMAND"

  labels = {
    "capacity/os"   = "AMAZON_LINUX"
    "capacity/type" = "ON_DEMAND"
    "capacity/arch" = "x86_64"
    #"ingress/ready" = "true"
  }

  depends_on = [
    #kubernetes_config_map.aws-auth
    aws_eks_access_entry.nodes
  ]

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }

  tags = {
    "kubernetes.io.cluster/${var.project_name}" = "owned"
  }

  timeouts {
    create = "1h"
    update = "2h"
    delete = "2h"
  }
}