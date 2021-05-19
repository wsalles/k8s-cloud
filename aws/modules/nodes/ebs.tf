resource "aws_ebs_volume" "storage-class" {
  availability_zone = data.aws_availability_zones.available.names[0]
  size              = 1

  tags = var.ebs_tags
}
