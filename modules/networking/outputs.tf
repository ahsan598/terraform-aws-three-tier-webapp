output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.main_vpc.id
}

output "vpc_igw_id" {
  description = "VPC Internet Gateway ID"
  value = aws_internet_gateway.vpc_igw.id
}

output "public_subnet_web_ids" {
  description = "List of public subnet IDs"
  value       = [for s in aws_subnet.public_web : s.id]
}

output "private_subnet_app_ids" {
  description = "List of private subnet IDs for app"
  value       = [for s in aws_subnet.private_app : s.id]
}

output "private_subnet_db_ids" {
  description = "List of private subnet IDs for database"
  value       = [for s in aws_subnet.private_db : s.id]
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = aws_nat_gateway.public_nat.id
}
