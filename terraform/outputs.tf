output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluser_endpoint" {
  value = module.eks.cluster_endpoint
}

output "eks_cluser_kms_key_arn" {
  value = module.eks.kms_key_arn
}

output "eks_worker_node_group_name" {
  value = element(split(":", module.eks.eks_managed_node_groups["${var.eks_cluster_name}"].node_group_id), 1)
}

output "vpc_public_subnets" {
  value = module.vpc.public_subnets
}

output "assume_eks_admins_role" {
  description = "EKS admin role ARN"
  value       = module.allow_assume_eks_admins_iam_policy.arn
}

output "eip_allocation_id" {
  value = aws_eip.cluster_loadbalancer_eip.allocation_id
}

output "eip_public_dns" {
  value = aws_eip.cluster_loadbalancer_eip.public_dns
}