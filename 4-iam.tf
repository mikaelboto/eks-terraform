resource "aws_iam_role" "eks-cluster-prod" {
  name = "${var.cluster-name}-eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "amazon-eks-cluster-policy-prod" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-prod.name
}

###################################NODES 

resource "aws_iam_role" "nodes-prod" {
  name = "${var.cluster-name}-eks-node-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "amazon-eks-worker-node-policy-prod" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes-prod.name
}

resource "aws_iam_role_policy_attachment" "amazon-eks-cni-policy-prod" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes-prod.name
}

resource "aws_iam_role_policy_attachment" "amazon-ec2-container-registry-read-only-prod" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes-prod.name
}

############### Auto Scaler ###########

resource "aws_iam_role" "as_role-prod" {
  name = "${var.cluster-name}-AWSServiceRoleForAutoScaling"

  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
 {
   "Effect": "Allow",
   "Principal": {
     "Service": "autoscaling.amazonaws.com"
   },
   "Action": "sts:AssumeRole"
  }
  ]
 }
EOF
}

resource "aws_iam_role_policy" "as_policy-prod" {
  name = "${var.cluster-name}-1-AWSServiceRoleForAutoScaling-policy"
  role = aws_iam_role.as_role-prod.id

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EC2InstanceManagement",
            "Effect": "Allow",
            "Action": [
                "ec2:AttachClassicLinkVpc",
                "ec2:CancelSpotInstanceRequests",
                "ec2:CreateFleet",
                "ec2:CreateTags",
                "ec2:DeleteTags",
                "ec2:Describe*",
                "ec2:DetachClassicLinkVpc",
                "ec2:ModifyInstanceAttribute",
                "ec2:RequestSpotInstances",
                "ec2:RunInstances",
                "ec2:StartInstances",
                "ec2:StopInstances",
                "ec2:TerminateInstances"
            ],
            "Resource": "*"
        },
        {
            "Sid": "EC2InstanceProfileManagement",
            "Effect": "Allow",
            "Action": [
                "iam:PassRole"
            ],
            "Resource": "*",
            "Condition": {
                "StringLike": {
                    "iam:PassedToService": "ec2.amazonaws.com*"
                }
            }
        },
        {
            "Sid": "EC2SpotManagement",
            "Effect": "Allow",
            "Action": [
                "iam:CreateServiceLinkedRole"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "iam:AWSServiceName": "spot.amazonaws.com"
                }
            }
        },
        {
            "Sid": "ELBManagement",
            "Effect": "Allow",
            "Action": [
                "elasticloadbalancing:Register*",
                "elasticloadbalancing:Deregister*",
                "elasticloadbalancing:Describe*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "CWManagement",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:DeleteAlarms",
                "cloudwatch:DescribeAlarms",
                "cloudwatch:GetMetricData",
                "cloudwatch:PutMetricAlarm"
            ],
            "Resource": "*"
        },
        {
            "Sid": "SNSManagement",
            "Effect": "Allow",
            "Action": [
                "sns:Publish"
            ],
            "Resource": "*"
        },
        {
            "Sid": "EventBridgeRuleManagement",
            "Effect": "Allow",
            "Action": [
                "events:PutRule",
                "events:PutTargets",
                "events:RemoveTargets",
                "events:DeleteRule",
                "events:DescribeRule"
            ],
            "Resource": "*",
            "Condition": {
                "StringEquals": {
                    "events:ManagedBy": "autoscaling.amazonaws.com"
                }
            }
        },
        {
            "Sid": "SystemsManagerParameterManagement",
            "Effect": "Allow",
            "Action": [
                "ssm:GetParameters"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

####################ELASTICSEARCH############

