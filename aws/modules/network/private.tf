resource "aws_subnet" "private_subnet_primary" {
  vpc_id     = aws_vpc.cluster_vpc.id
  cidr_block = "10.0.32.0/20"

  //  availability_zone = format("%sa", var.aws_region)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name                                        = format("%s-private-primary", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "private_subnet_secondary" {
  vpc_id     = aws_vpc.cluster_vpc.id
  cidr_block = "10.0.48.0/20"

  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name                                        = format("%s-private-secondary", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_route_table_association" "private-primary" {
  subnet_id      = aws_subnet.private_subnet_primary.id
  route_table_id = aws_route_table.nat.id
}

resource "aws_route_table_association" "private-secondary" {
  subnet_id      = aws_subnet.private_subnet_secondary.id
  route_table_id = aws_route_table.nat.id
}