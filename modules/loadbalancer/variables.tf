variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the ALB will be deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "alb_security_group_ids" {
  description = "Security group ID for ALB"
  type        = list(string)
}

variable "web_port" {
  description = "Port for the EC2 instance"
  type        = number
}

variable "web_protocol" {
  description = "Protocol for the EC2 instance"
  type        = string
}

variable "web_target" {
  description = "Target type for the EC2 instance"
  type        = string
}

variable "listener_port" {
  description = "Port for the ALB listener"
  type        = number
}

variable "listener_protocol" {
  description = "Protocol for the ALB listener"
  type        = string
}

variable "health_check_path" {
  description = "Health check endpoint path"
  type        = string
}

variable "health_check_matcher" {
  description = "HTTP codes to use when checking for a successful response from a target"
  type        = string
}

variable "enable_https" {
  description = "Enable HTTPS listener"
  type        = bool
}

variable "enable_deletion_protection" {
  description = "Enable deletion protection for the ALB"
  type        = bool
}

variable "enable_cross_zone_load_balancing" {
  description = "Enable cross-zone load balancing for the ALB"
  type        = bool
}

variable "ssl_certificate_arn" {
  description = "ARN of the SSL certificate for HTTPS listener"
  type        = string
  default     = ""
}