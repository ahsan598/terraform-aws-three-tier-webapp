# ============================================
# VPC Configuration Outputs
# ============================================
output "vpc_id" {
  description = "VPC ID"
  value       = module.aws_vpc.vpc_id
}

output "vpc_igw_id" {
  description = "VPC Internet Gateway ID"
  value       = module.aws_vpc.vpc_igw_id
}

output "public_subnet_web_ids" {
  description = "List of public subnet IDs"
  value       = module.aws_vpc.public_subnet_web_ids
}

output "private_subnet_app_ids" {
  description = "List of private subnet IDs for app"
  value       = module.aws_vpc.private_subnet_app_ids
}

output "private_subnet_db_ids" {
  description = "List of private subnet IDs for database"
  value       = module.aws_vpc.private_subnet_db_ids
}

output "nat_gateway_id" {
  description = "NAT Gateway ID"
  value       = module.aws_vpc.nat_gateway_id
}


# ============================================
# EC2 Configuration Outputs
# ============================================
output "ec2_instance_ids" {
  description = "EC2 instance IDs created by the EC2 module"
  value       = module.ec2.instance_ids
}

output "rds_endpoint" {
  description = "RDS endpoint created by the RDS module"
  value       = module.rds.endpoint
}