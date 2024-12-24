## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.7.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0, < 6.0.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.16.1 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | ~> 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.24.0 |
| <a name="requirement_sops"></a> [sops](#requirement\_sops) | ~> 0.5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.82.2 |
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.16.1 |
| <a name="provider_kubectl"></a> [kubectl](#provider\_kubectl) | 1.14.0 |
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | 2.24.0 |
| <a name="provider_sops"></a> [sops](#provider\_sops) | 0.7.2 |
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_allow_assume_eks_admins_iam_policy"></a> [allow\_assume\_eks\_admins\_iam\_policy](#module\_allow\_assume\_eks\_admins\_iam\_policy) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy | e20e0b9a42084bbc885fd5abb18b8744810bd567 |
| <a name="module_allow_eks_access_iam_policy"></a> [allow\_eks\_access\_iam\_policy](#module\_allow\_eks\_access\_iam\_policy) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-policy | e20e0b9a42084bbc885fd5abb18b8744810bd567 |
| <a name="module_ebs_csi_irsa"></a> [ebs\_csi\_irsa](#module\_ebs\_csi\_irsa) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-role-for-service-accounts-eks | e20e0b9a42084bbc885fd5abb18b8744810bd567 |
| <a name="module_eks"></a> [eks](#module\_eks) | git::https://github.com/terraform-aws-modules/terraform-aws-eks.git | 2cb1fac31b0fc2dd6a236b0c0678df75819c5a3b |
| <a name="module_eks_admins_iam_role"></a> [eks\_admins\_iam\_role](#module\_eks\_admins\_iam\_role) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-assumable-role | e20e0b9a42084bbc885fd5abb18b8744810bd567 |
| <a name="module_iam_user"></a> [iam\_user](#module\_iam\_user) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-user | e20e0b9a42084bbc885fd5abb18b8744810bd567 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | git::https://github.com/terraform-aws-modules/terraform-aws-vpc.git | 573f574c922782bc658f05523d0c902a4792b0a8 |
| <a name="module_vpc_cni_irsa"></a> [vpc\_cni\_irsa](#module\_vpc\_cni\_irsa) | git::https://github.com/terraform-aws-modules/terraform-aws-iam.git//modules/iam-role-for-service-accounts-eks | e20e0b9a42084bbc885fd5abb18b8744810bd567 |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_eip.cluster_loadbalancer_eip](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_iam_group.eks_admins_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group) | resource |
| [aws_iam_group_membership.eks_admins_group_membership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_membership) | resource |
| [aws_iam_group_policy_attachment.eks_admins_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment) | resource |
| [aws_iam_policy.ecr_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.ecr_pull_through_cache](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.s3_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_security_group.vpc_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.vpc_endpoint_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.vpc_endpoint_self_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_vpc_endpoint.ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.sts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_security_group_ingress_rule.vpc_endpoints_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [helm_release.flask_app](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.ingress_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubectl_manifest.ebs_storage_classes](https://registry.terraform.io/providers/gavinbunney/kubectl/latest/docs/resources/manifest) | resource |
| [kubernetes_annotations.set_defaut_storage_class](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/annotations) | resource |
| [kubernetes_annotations.unset_eks_default_gp2](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/annotations) | resource |
| [terraform_data.ecr_image](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/resources/data) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [sops_file.flast_app_secrets](https://registry.terraform.io/providers/carlpett/sops/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_AWS_ACCESS_KEY_ID"></a> [AWS\_ACCESS\_KEY\_ID](#input\_AWS\_ACCESS\_KEY\_ID) | AWS access key associated with an IAM account | `string` | `""` | no |
| <a name="input_AWS_PROFILE"></a> [AWS\_PROFILE](#input\_AWS\_PROFILE) | AWS Profile that resources are created in | `string` | `"default"` | no |
| <a name="input_AWS_REGION"></a> [AWS\_REGION](#input\_AWS\_REGION) | Target AWS region | `string` | `"eu-west-2"` | no |
| <a name="input_AWS_SECRET_ACCESS_KEY"></a> [AWS\_SECRET\_ACCESS\_KEY](#input\_AWS\_SECRET\_ACCESS\_KEY) | AWS secret key associated with the access key | `string` | `""` | no |
| <a name="input_AWS_SESSION_TOKEN"></a> [AWS\_SESSION\_TOKEN](#input\_AWS\_SESSION\_TOKEN) | Session token for temporary security credentials from AWS STS | `string` | `""` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tags associated to resources created | `map(string)` | <pre>{<br/>  "Environment": "dev",<br/>  "Project": "aws-eks-terraform"<br/>}</pre> | no |
| <a name="input_defaut_storage_class"></a> [defaut\_storage\_class](#input\_defaut\_storage\_class) | Default storage class used for describing the EBS usage | `string` | `"ebs-sc-gp2"` | no |
| <a name="input_eks_admins_group_users"></a> [eks\_admins\_group\_users](#input\_eks\_admins\_group\_users) | EKS admin IAM user group | `list(string)` | `[]` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | EKS cluster name | `string` | `"aws-eks-terraform"` | no |
| <a name="input_eks_kubernetes_version"></a> [eks\_kubernetes\_version](#input\_eks\_kubernetes\_version) | Amazon EKS Kubernetes version | `string` | `"1.31"` | no |
| <a name="input_flast_app_api_base_url"></a> [flast\_app\_api\_base\_url](#input\_flast\_app\_api\_base\_url) | Value for api\_base\_url variable in Flast APP Helm Chart | `string` | `"http://google.com"` | no |
| <a name="input_flast_app_log_level"></a> [flast\_app\_log\_level](#input\_flast\_app\_log\_level) | Value for log\_level variable in Flast APP Helm Chart | `string` | `"INFO"` | no |
| <a name="input_flast_app_max_connections"></a> [flast\_app\_max\_connections](#input\_flast\_app\_max\_connections) | Value for max\_connections variable in Flast APP Helm Chart | `string` | `"100"` | no |
| <a name="input_instance_capacity_type"></a> [instance\_capacity\_type](#input\_instance\_capacity\_type) | Capacity type used by EKS managed node groups | `string` | `"ON_DEMAND"` | no |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | List of instance types used by EKS managed node groups | `list(any)` | <pre>[<br/>  "t3.large"<br/>]</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | VPC CIDR | `string` | `"10.0.0.0/16"` | no |
| <a name="input_vpc_private_subnet_cidr"></a> [vpc\_private\_subnet\_cidr](#input\_vpc\_private\_subnet\_cidr) | List of private subnet configurations | `list(any)` | <pre>[<br/>  "10.0.0.0/19",<br/>  "10.0.32.0/19",<br/>  "10.0.64.0/19"<br/>]</pre> | no |
| <a name="input_vpc_public_subnet_cidr"></a> [vpc\_public\_subnet\_cidr](#input\_vpc\_public\_subnet\_cidr) | List of public subnet configurations | `list(any)` | <pre>[<br/>  "10.0.96.0/19",<br/>  "10.0.128.0/19",<br/>  "10.0.160.0/19"<br/>]</pre> | no |
| <a name="input_worker_node_size"></a> [worker\_node\_size](#input\_worker\_node\_size) | Node size of the worker node group | `map(number)` | <pre>{<br/>  "desired": 1,<br/>  "max": 1,<br/>  "min": 0<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_assume_eks_admins_role"></a> [assume\_eks\_admins\_role](#output\_assume\_eks\_admins\_role) | EKS admin role ARN |
| <a name="output_eip_public_dns"></a> [eip\_public\_dns](#output\_eip\_public\_dns) | The URL to access the applications |
| <a name="output_eks_cluser_kms_key_arn"></a> [eks\_cluser\_kms\_key\_arn](#output\_eks\_cluser\_kms\_key\_arn) | n/a |
| <a name="output_eks_cluster_name"></a> [eks\_cluster\_name](#output\_eks\_cluster\_name) | n/a |