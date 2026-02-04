output "instance_ids" {
  description = "IDs of the created EC2 instances"
  value       = aws_instance.web.*.id
}

output "public_ips" {
  description = "Public IPs of the created EC2 instances"
  value       = aws_instance.web.*.public_ip
}