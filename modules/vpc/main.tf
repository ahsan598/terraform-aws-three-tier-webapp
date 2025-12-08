# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
}

# Create public subnets
resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)
  cidr_block = each.value
  vpc_id     = aws_vpc.main.id
  map_public_ip_on_launch = true
}

# Create private subnets
resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)
  cidr_block = each.value
  vpc_id     = aws_vpc.main.id
}

# NAT Gateway for Private Subnets
resource "aws_nat_gateway" "ps_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id  # Access the first subnet's id
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat" {
  domain = "vpc"
}