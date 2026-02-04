# ============================================
# Providers Variable
# ============================================
variable "aws_region" {
  description = "AWS region for resources"
  type        = string
}

variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

# ============================================
# VPC Configuration Variables
# ============================================
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string

  validation {
    condition     = can(cidrnetmask(var.vpc_cidr))
    error_message = "vpc_cidr must be a valid CIDR block (e.g. 10.0.0.0/16)."
  }
}

variable "availability_zones" {
  description = "AZs where subnets will be created"
  type        = list(string)
}

variable "public_subnets_web" {
  description = "Public subnet CIDRs (same length as availability zones)"
  type        = list(string)
}

variable "private_subnets_app" {
  description = "Private subnet CIDRs (same length as availability zones)"
  type        = list(string)
}

variable "private_subnets_db" {
  description = "Private subnet CIDRs (same length as availability zones)"
  type        = list(string)
}




variable "key_name" {
  description = "Key pair name for EC2 instances"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for EC2 instances"
  type        = string
}

variable "db_name" {
  description = "The name of the database to create on RDS"
  type        = string
}

variable "db_username" {
  description = "Username for the RDS database"
  type        = string
}

variable "db_password" {
  description = "Password for the RDS database"
  type        = string
}

variable "db_instance_class" {
  description = "Instance class for the RDS database"
  type        = string
}