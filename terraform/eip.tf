resource "aws_eip" "cluster_loadbalancer_eip" {
  vpc              = true
  public_ipv4_pool = "amazon"
  tags             = merge(tomap({ "Name" : "${var.eks_cluster_name}-loadbalancer-eip" }), var.common_tags)
}
