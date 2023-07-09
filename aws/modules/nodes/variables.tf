variable "aws_region" {}

variable "cluster_name" {}

variable "cluster_version" {}

variable "cluster_vpc" {}

variable "private_subnet_primary" {}

variable "private_subnet_secondary" {}

variable "eks_cluster" {}

variable "eks_cluster_sg" {}

variable "nodes_instances_sizes" {}

variable "auto_scale_options" {}

variable "auto_scale_cpu" {}

variable "ebs_tags" {
  type = map(string)
}
