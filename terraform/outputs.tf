output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluser_kms_key_arn" {
  value = module.eks.kms_key_arn
}

output "assume_eks_admins_role" {
  description = "EKS admin role ARN"
  value       = module.allow_assume_eks_admins_iam_policy.arn
}

output "eip_public_dns" {
  description = "The URL to access the applications"
  value       = aws_eip.cluster_loadbalancer_eip.public_dns
}
