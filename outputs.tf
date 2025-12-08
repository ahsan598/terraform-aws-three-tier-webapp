output "vpc_id" {
  description = "VPC ID created by the VPC module"
  value       = module.vpc.vpc_id
}

output "ec2_instance_ids" {
  description = "EC2 instance IDs created by the EC2 module"
  value       = module.ec2.instance_ids
}

output "rds_endpoint" {
  description = "RDS endpoint created by the RDS module"
  value       = module.rds.endpoint
}