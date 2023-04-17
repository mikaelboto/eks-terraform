resource "aws_eks_cluster" "cluster-prod" {
  name     = var.cluster-name
  version  = var.k8s-version
  role_arn = aws_iam_role.eks-cluster-prod.arn

  vpc_config {

    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    security_group_ids = [aws_security_group.sg-cluster-prod.id]

    subnet_ids  = [
      aws_subnet.private-subnet-1-prod.id,aws_subnet.private-subnet-2-prod.id,aws_subnet.private-subnet-3-prod.id]
  }

  enabled_cluster_log_types = var.eks-cw-logging

  depends_on = [aws_iam_role_policy_attachment.amazon-eks-cluster-policy-prod]
}
