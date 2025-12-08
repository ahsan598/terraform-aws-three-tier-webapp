output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]  # Use a for loop to extract subnet IDs from the map
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}