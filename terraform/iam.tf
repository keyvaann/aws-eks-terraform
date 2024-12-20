module "allow_eks_access_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.48.0"

  name          = "${var.eks_cluster_name}-allow-eks-access"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "eks:DescribeCluster",

          # # Further enable and narrow down access permissions below for your admin users.
          # "eks:*",
          # "ec2:*",
          # "iam:*",
          # "cloudwatch:*",
          # "kms:*",
          # "logs:*",
          # "autoscaling:*",
          # "elasticloadbalancing:*",
          # # For accessing optional resources
          # "rds:*",
          # "route53:*",
          # "ses:*",
          # "kafka:*",
          # "s3:*",
          # "sqs:*",
          # "events:*",
          # "sns:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })

  tags = merge(tomap({ "Name" : "${var.eks_cluster_name}-allow-eks-access" }), var.common_tags)
}

module "eks_admins_iam_role" {
  source           = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  version          = "5.48.0"
  role_description = "The administrative role for the EKS cluster"

  role_name         = "${var.eks_cluster_name}-admin-role"
  create_role       = true
  role_requires_mfa = false

  custom_role_policy_arns = [module.allow_eks_access_iam_policy.arn]

  trusted_role_arns = [
    "arn:aws:iam::${module.vpc.vpc_owner_id}:root"
  ]

  tags = merge(tomap({ "Name" : "${var.eks_cluster_name}-admin-role" }), var.common_tags)
}


module "allow_assume_eks_admins_iam_policy" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-policy"
  version = "5.48.0"

  name          = "${var.eks_cluster_name}-allow-assume-eks-admin-role"
  create_policy = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole",
        ]
        Effect   = "Allow"
        Resource = module.eks_admins_iam_role.iam_role_arn
      },
    ]
  })

  tags = merge(tomap({ "Name" : "${var.eks_cluster_name}-allow-assume-eks-admin-role" }), var.common_tags)
}

resource "aws_iam_group" "eks_admins_group" {
  name = "${var.eks_cluster_name}-admins"
  path = "/${var.eks_cluster_name}/"
}

resource "aws_iam_group_policy_attachment" "eks_admins_policy_attachment" {
  group      = "${var.eks_cluster_name}-admins"
  policy_arn = module.allow_assume_eks_admins_iam_policy.arn

  depends_on = [aws_iam_group.eks_admins_group]
}

resource "aws_iam_group_membership" "eks_admins_group_membership" {
  name = "${var.eks_cluster_name}-admin-users"

  users = var.eks_admins_group_users
  group = "${var.eks_cluster_name}-admins"

  depends_on = [aws_iam_group.eks_admins_group]
}

module "iam_user" {
  source = "terraform-aws-modules/iam/aws//modules/iam-user"

  name                          = "${var.eks_cluster_name}-ecr-readonly-user"
  create_iam_user_login_profile = false
  create_iam_access_key         = false
  force_destroy                 = false
  policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly",
    "arn:aws:iam::aws:policy/AmazonElasticContainerRegistryPublicReadOnly",
  ]

  tags = merge(tomap({ "Name" : "${var.eks_cluster_name}-ecr-readonly-user" }), var.common_tags)
}

resource "aws_iam_policy" "s3_access" {
  name = "${var.eks_cluster_name}-s3-access-policy"
  path = "/eks/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = [
          "arn:aws:s3:::${var.eks_cluster_name}-*/*",
        ]
      }
    ]
  })

  tags = merge(tomap({ "Name" : "${var.eks_cluster_name}-s3-access-policy" }), var.common_tags)
}

resource "aws_iam_policy" "ecr_access" {
  name = "${var.eks_cluster_name}-ecr-access-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetRepositoryPolicy",
          "ecr:DescribeRepositories",
          "ecr:ListImages",
          "ecr:DescribeImages",
          "ecr:BatchGetImage",
          "ecr:GetLifecyclePolicy",
          "ecr:GetLifecyclePolicyPreview",
          "ecr:ListTagsForResource",
          "ecr:DescribeImageScanFindings"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(tomap({ "Name" : "${var.eks_cluster_name}-ecr-access-policy" }), var.common_tags)
}

resource "aws_iam_policy" "ecr_pull_through_cache" {
  name = "${var.eks_cluster_name}-ecr-pull-through-cache-policy"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ecr:CreatePullThroughCacheRule",
          "ecr:BatchImportUpstreamImage",
          "ecr:CreateRepository"
        ]
        Resource = "*"
      }
    ]
  })

  tags = merge(tomap({ "Name" : "${var.eks_cluster_name}-ecr-pull-through-cache-policy" }), var.common_tags)
}