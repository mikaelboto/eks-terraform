resource "aws_eks_node_group" "eks-node-group-prod" {
  cluster_name    = aws_eks_cluster.cluster-prod.name
  node_group_name = var.node-name
  node_role_arn   = aws_iam_role.nodes-prod.arn

 subnet_ids  = [
   aws_subnet.private-subnet-1-prod.id,aws_subnet.private-subnet-2-prod.id,aws_subnet.private-subnet-3-prod.id]

  capacity_type  = "ON_DEMAND"
  instance_types = []

  scaling_config {
    desired_size = var.desired-capacity
    max_size     = var.max-size
    min_size     = var.min-size
  }

  launch_template {
    name    = aws_launch_template.foo-pdv-sdx.name
    version = "1"
  }

  update_config {
    max_unavailable = 1
  }

  labels = {
    role = "role-prod-inforplus"
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon-eks-worker-node-policy-prod,
    aws_iam_role_policy_attachment.amazon-eks-cni-policy-prod,
    aws_iam_role_policy_attachment.amazon-ec2-container-registry-read-only-prod,
  ]

  # Allow external changes without Terraform plan difference
  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }
}
