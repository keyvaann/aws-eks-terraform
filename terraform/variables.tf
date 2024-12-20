variable "AWS_REGION" {
  type        = string
  description = "Target AWS region"
  default     = "eu-west-2"
}

variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "AWS access key associated with an IAM account"
  default     = ""
  sensitive   = true
}

variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "AWS secret key associated with the access key"
  default     = ""
  sensitive   = true
}

variable "AWS_SESSION_TOKEN" {
  type        = string
  description = "Session token for temporary security credentials from AWS STS"
  default     = ""
  sensitive   = true
}

variable "AWS_PROFILE" {
  type        = string
  description = "AWS Profile that resources are created in"
  default     = "default"
}

variable "eks_cluster_name" {
  type        = string
  description = "EKS cluster name"

  default = "aws-eks-terraform"

  validation {
    condition     = length(var.eks_cluster_name) > 0
    error_message = "The cluster name cannot be empty."
  }
}

variable "environment" {
  type        = string
  description = "Environment name"
  default     = "dev"
}

variable "common_tags" {
  type        = map(string)
  description = "Common tags associated to resources created"
  default = {
    Project     = "aws-eks-terraform"
    Environment = "dev"
  }
}

variable "eks_kubernetes_version" {
  type        = string
  description = "Amazon EKS Kubernetes version"
  default     = "1.31"

  validation {
    condition     = contains(["1.31", "1.30", "1.29", "1.28"], var.eks_kubernetes_version)
    error_message = "Invalid EKS Kubernetes version. Supported versions are '1.31', '1.30', '1.29', '1.28'."
  }
}

variable "instance_types" {
  type        = list(any)
  description = "List of instance types used by EKS managed node groups"
  default     = ["t3.large"]
}

variable "instance_capacity_type" {
  type        = string
  description = "Capacity type used by EKS managed node groups"
  default     = "ON_DEMAND"

  validation {
    condition     = var.instance_capacity_type == "ON_DEMAND" || var.instance_capacity_type == "SPOT"
    error_message = "Invalid instance capacity type. Allowed values are 'ON_DEMAND', 'SPOT'."
  }
}

variable "worker_node_size" {
  type        = map(number)
  description = "Node size of the worker node group"
  default = {
    "desired" = 1
    "min"     = 0
    "max"     = 1
  }
}

variable "eks_admins_group_users" {
  type        = list(string)
  description = "EKS admin IAM user group"
  default     = []
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "vpc_private_subnet_cidr" {
  description = "List of private subnet configurations"
  type        = list(any)
  default = [
    "10.0.0.0/19",
    "10.0.32.0/19",
    "10.0.64.0/19",
  ]
}

variable "vpc_public_subnet_cidr" {
  description = "List of public subnet configurations"
  type        = list(any)
  default = [
    "10.0.96.0/19",
    "10.0.128.0/19",
    "10.0.160.0/19",
  ]
}

variable "defaut_storage_class" {
  type        = string
  description = "Default storage class used for describing the EBS usage"
  default     = "ebs-sc-gp2"

  validation {
    condition     = var.defaut_storage_class == "ebs-sc-gp2" || var.defaut_storage_class == "ebs-sc-gp3" || var.defaut_storage_class == "ebs-sc-io1" || var.defaut_storage_class == "ebs-sc-io2"
    error_message = "Invalid storage class. Allowed values are 'ebs-sc-gp2', 'ebs-sc-gp3', 'ebs-sc-io1' or 'ebs-sc-io2'."
  }
}

variable "flast_app_api_base_url" {
  type        = string
  description = "Value for api_base_url variable in Flast APP Helm Chart"
  default     = "http://google.com"
}

variable "flast_app_log_level" {
  type        = string
  description = "Value for log_level variable in Flast APP Helm Chart"
  default     = "INFO"
}

variable "flast_app_max_connections" {
  type        = string
  description = "Value for max_connections variable in Flast APP Helm Chart"
  default     = "100"
}