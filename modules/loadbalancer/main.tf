# ============================================
# APPLICATION LOAD BALANCER
# ============================================
resource "aws_lb" "main_alb" {
  name                        = "${var.project_name}-alb"
  internal                    = false
  load_balancer_type          = "application"
  security_groups             = var.alb_security_group_ids
  subnets                     = var.public_subnet_ids
  enable_deletion_protection  = var.enable_deletion_protection

  # Enable cross-zone load balancing
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing

  tags   = {
    Name = "${var.project_name}-alb"
  }
}

# ============================================
# Target Group for EC2 Instance (WEB TIER)
# ============================================
resource "aws_lb_target_group" "web" {
  name        = "${var.project_name}-web-tg"
  port        = var.web_port
  protocol    = var.web_protocol
  target_type = var.web_target
  vpc_id      = var.vpc_id

# Health Check Configuration
  health_check {
    enabled             = true
    path                = var.health_check_path
    matcher             = var.health_check_matcher
  }

# Ensure Target Group is created before destroying the old one
  lifecycle {
    create_before_destroy = true
  }

  tags   = {
    Name = "${var.project_name}-web-tg"
  }

# Ensure ALB is created first
  depends_on = [ aws_lb.main_alb ]
}

# ============================================
# ALB Listener for HTTP
# ============================================
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main_alb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.web.arn
  }

  tags   = {
    Name = "${var.project_name}-alb-listener"
  }
}
