resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list = ["sts.amazonaws.com"]
  tumbprint_list = [
    data.tls_certificate.eks.certificates[0].sha1_fingerprint,
  ]
  url = flatten(concat(aws_eks_cluster.cluster[*].identity[*].oidc.0.issuer, [""]))[0]
}
