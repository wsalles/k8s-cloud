output "cluster_vpc" {
  value = aws_vpc.cluster_vpc
}

output "private_subnet_primary" {
  value = aws_subnet.private_subnet_primary
}

output "private_subnet_secondary" {
  value = aws_subnet.private_subnet_secondary
}

output "public_subnet_primary" {
  value = aws_subnet.public_subnet_primary
}

output "public_subnet_secondary" {
  value = aws_subnet.public_subnet_secondary
}