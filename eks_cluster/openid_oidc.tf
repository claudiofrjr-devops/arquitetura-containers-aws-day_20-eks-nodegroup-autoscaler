# data "tls_certificate" "eks" {
#   url = aws_eks_cluster.main.identity[0].oidc.0.issuer
# }

# resource "aws_iam_openid_connect_provider" "eks" {
#   client_id_list = [
#     "sts.amazonaws.com",
#   ]
#   thumbprint_list = [
#     data.tls_certificate.eks.certificates[0].sha1_fingerprint,
#     "cf23df2207d99a74fbe169e3eba035e633b65d94"
#   ]
#   url = flatten(concat(aws_eks_cluster.main[*].identity[*].oidc.0.issuer, [""]))[0]
# }

## Codigo do GIthub Fidelis ##

data "tls_certificate" "eks" {
  url = aws_eks_cluster.main.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = [
    data.tls_certificate.eks.certificates[0].sha1_fingerprint,
    "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
  ]
  url = flatten(concat(aws_eks_cluster.main[*].identity[*].oidc.0.issuer, [""]))[0]
}