resource "aws_subnet" "public_subnet_primary" {
  vpc_id = aws_vpc.cluster_vpc.id

  cidr_block              = "10.0.0.0/20"
  map_public_ip_on_launch = true
  //  availability_zone       = format("%sa", var.aws_region)
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    "Name"                                      = format("%s-public-primary", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_subnet" "public_subnet_secondary" {
  vpc_id = aws_vpc.cluster_vpc.id

  cidr_block              = "10.0.16.0/20"
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[1]

  tags = {
    "Name"                                      = format("%s-public-secondary", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}

resource "aws_route_table_association" "public_primary" {
  subnet_id      = aws_subnet.public_subnet_primary.id
  route_table_id = aws_route_table.igw_route_table.id
}

resource "aws_route_table_association" "public_secondary" {
  subnet_id      = aws_subnet.public_subnet_secondary.id
  route_table_id = aws_route_table.igw_route_table.id
}
