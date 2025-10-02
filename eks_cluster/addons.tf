resource "aws_eks_addon" "cni" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "vpc-cni"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  addon_version = var.addon_cni_version

  depends_on = [aws_eks_access_entry.nodes]

}

resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "coredns"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  addon_version = var.addon_core_dns_version

  depends_on = [aws_eks_access_entry.nodes]
}

resource "aws_eks_addon" "kubeproxy" {
  cluster_name = aws_eks_cluster.main.name
  addon_name   = "kube-proxy"

  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"

  addon_version = var.addon_kubeproxy_version

  depends_on = [aws_eks_access_entry.nodes]

}