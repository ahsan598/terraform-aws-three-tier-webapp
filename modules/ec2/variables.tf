variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs where EC2 instances will be created"
  type        = list(string)
}

variable "vpc_id" {
  description = "ID of the VPC where the EC2 instances will be created"
  type        = string
}