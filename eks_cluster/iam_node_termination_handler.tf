data "aws_iam_policy_document" "node_termination_handler" {
  version = "2012-10-17"

  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    effect = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values = [
        "system:serviceaccount:kube-system:aws-node-termination-handler"
      ]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }

}

resource "aws_iam_role" "node_termination_handler" {
  name               = format("%s-node_termination_handler", var.project_name)
  assume_role_policy = data.aws_iam_policy_document.node_termination_handler.json
}

data "aws_iam_policy_document" "aws_node_termination_handler_policy" {
  version = "2012-10-17"

  statement {

    effect = "Allow"
    actions = [
      "autoscaling:CompleteLifecycleAction",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeTags",
      "ec2:DescribeInstances",
      "sqs:DeleteMessage",
      "sqs:ReceiveMessage"
    ]

    resources = [
      "*"
    ]

  }
}

resource "aws_iam_policy" "node_termination_handler" {
  name   = format("%s-node_termination_handler", var.project_name)
  policy = data.aws_iam_policy_document.aws_node_termination_handler_policy.json
}

resource "aws_iam_role_policy_attachment" "node_termination_handler" {
  policy_arn = aws_iam_policy.node_termination_handler.arn
  role       = aws_iam_role.node_termination_handler.name

}