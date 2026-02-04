# ============================
# VPC CONFIGURATION
# ============================
resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# ============================
# INTERNET GATEWAY FOR VPC
# ============================
resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# ============================
# PUBLIC SUBNET (WEB TIER)
# ============================
resource "aws_subnet" "public_web" {
  for_each                = local.public_subnet_map_web
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-web-${each.key}"
    Tier = "public"
  }
}

# ==================================
# PUBLIC ROUTE TABLE & ASSOCIATION
# ==================================
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }

  tags = {
    Name = "${var.project_name}-public-web-rt"
  }
}

resource "aws_route_table_association" "public_assoc" {
  for_each       = aws_subnet.public_web
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

# ============================
# ELASTIC IP & NAT GATEWAY
# ============================
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

resource "aws_nat_gateway" "public_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_web[var.availability_zones[0]].id

  depends_on = [aws_internet_gateway.vpc_igw]

  tags = {
    Name = "${var.project_name}-nat"
  }
}

# ===============================
# PRIVATE SUBNET (APP TIER)
# ===============================
resource "aws_subnet" "private_app" {
  for_each          = local.private_subnet_map_app
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "${var.project_name}-private-app-${each.key}"
    Tier = "private"
  }
}

# =============================================
# PRIVATE ROUTE TABLE & ASSOCIATION (APP TIER)
# =============================================
resource "aws_route_table" "private_rt_app" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat.id
  }

  tags = {
    Name = "${var.project_name}-private-app-rt"
  }
}

resource "aws_route_table_association" "private_assoc_app" {
  for_each       = aws_subnet.private_app
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt_app.id
}

# =================================
# PRIVATE SUBNET (DATABASE)
# =================================
resource "aws_subnet" "private_db" {
  for_each          = local.private_subnet_map_db
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name = "${var.project_name}-private-db-${each.key}"
    Tier = "private"
  }
}

# =============================================
# PRIVATE ROUTE TABLE & ASSOCIATION (DATABASE)
# =============================================
resource "aws_route_table" "private_rt_db" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "${var.project_name}-private-db-rt"
  }
}

resource "aws_route_table_association" "private_assoc_db" {
  for_each       = aws_subnet.private_db
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt_db.id
}
