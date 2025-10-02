resource "helm_release" "node_termination_handler" {
  name      = "aws-node-termination-handler"
  namespace = "kube-system"

  chart      = "aws-node-termination-handler"
  repository = "https://aws.github.io/eks-charts/"

  set = [
    {
      name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
      value = aws_iam_role.node_termination_handler.arn
    },
    {
      name  = "awsRegion"
      value = data.aws_region.current.id
    },
    {
      name  = "queueURL"
      value = aws_sqs_queue.node_termination.url
    },
    {
      name  = "enableSqsTerminationDraining"
      value = true
    },
    {
      name  = "enableSpotInterruptionDraining"
      value = true
    },
    {
      name  = "enableRebalanceMonitoring"
      value = true
    },
    {
      name  = "enableRebalanceDraining"
      value = true
    },
    {
      name  = "enableScheduledEventDraining"
      value = true
    },
    {
      name  = "deleteSqsMsgIfNodeNotFound"
      value = true
    },
    {
      name  = "checkTagBeforeDraining"
      value = false
    }
  ]
}