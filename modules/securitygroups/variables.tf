variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_id" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "app_port" {
  description = "Port on which the ECS container listens"
  type        = number

  validation {
    condition     = var.container_port > 0 && var.container_port < 65536
    error_message = "container_port must be between 1 and 65535"
  }
}

variable "enable_https" {
  description = "Enable HTTPS ingress rule for ALB"
  type        = bool
}

variable "enable_vpc_endpoints" {
  description = "Enable VPC endpoints security group (for private ECS without NAT)"
  type        = bool
}
