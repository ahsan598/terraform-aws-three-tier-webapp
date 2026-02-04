variable "project_name" {
  description = "Name of the project"
  type        = string
}

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
