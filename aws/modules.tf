module "network" {
  source = "./modules/network"

  cluster_name = var.cluster_name
  aws_region   = var.aws_region
}

module "master" {
  source = "./modules/master"

  cluster_name = var.cluster_name
  aws_region   = var.aws_region
  k8s_version  = var.k8s_version

  cluster_vpc              = module.network.cluster_vpc
  private_subnet_primary   = module.network.private_subnet_primary
  private_subnet_secondary = module.network.private_subnet_secondary
}

module "nodes" {
  source = "./modules/nodes"

  cluster_name = var.cluster_name
  aws_region   = var.aws_region
  k8s_version  = var.k8s_version

  cluster_vpc              = module.network.cluster_vpc
  private_subnet_primary   = module.network.private_subnet_primary
  private_subnet_secondary = module.network.private_subnet_secondary

  eks_cluster    = module.master.eks_cluster
  eks_cluster_sg = module.master.security_group

  nodes_instances_sizes = var.nodes_instances_sizes
  auto_scale_options    = var.auto_scale_options

  auto_scale_cpu = var.auto_scale_cpu

  ebs_tags = var.ebs_tags
}