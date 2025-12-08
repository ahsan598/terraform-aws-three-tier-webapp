output "endpoint" {
  description = "RDS database endpoint"
  value       = aws_db_instance.db.endpoint
}

output "db_subnet_group" {
  description = "RDS database subnet group"
  value       = aws_db_subnet_group.db_subnet_group.name
}