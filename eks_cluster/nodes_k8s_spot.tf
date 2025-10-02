resource "aws_eks_node_group" "bottlerocket" {

  cluster_name    = aws_eks_cluster.main.id
  node_group_name = format("%s-bottlerocket", aws_eks_cluster.main.id)

  node_role_arn = aws_iam_role.eks_nodes_role.arn

  instance_types = var.nodes_instance_sizes

  scaling_config {
    desired_size = lookup(var.auto_scale_option, "desired")
    max_size     = lookup(var.auto_scale_option, "max")
    min_size     = lookup(var.auto_scale_option, "min")
  }

  subnet_ids = data.aws_ssm_parameter.pod_subnets[*].value

  capacity_type = "ON_DEMAND"

  ami_type = "BOTTLEROCKET_X86_64"

  labels = {
    "capacity/os"   = "BOTTLEROCKET"
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