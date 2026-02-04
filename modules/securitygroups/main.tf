# =============================
# Security Group (WEB TIER)
# =============================
resource "aws_security_group" "web_sg" {
  name        = "${var.project_name}-web-sg"
  description = "Web tier SG"
  vpc_id      = module.aws_vpc.vpc_id
}

# =================================================
# Allow HTTP/HTTPS Traffic from Internet
# =================================================
resource "aws_vpc_security_group_ingress_rule" "web_http" {
  security_group_id = aws_security_group.web_sg.id
  description       = "Allow HTTP inbound from internet"

  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "web_https" {
  count             = var.enable_https ? 1 : 0
  security_group_id = aws_security_group.web_sg.id
  description       = "Allow HTTPS inbound from internet"

  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

# ==============================================================
# Allow Egress Traffic (Outbound: Allow to App SG (8080)) 
# ==============================================================
resource "aws_vpc_security_group_egress_rule" "web_to_app" {
  security_group_id            = aws_security_group.web_sg.id
  description                  = "Allow traffic to App"

  referenced_security_group_id = aws_security_group.app_sg.id
  from_port                    = var.app_port
  to_port                      = var.app_port
  ip_protocol                  = "tcp"
}

# =============================
# Security Group (APP TIER)
# =============================
resource "aws_security_group" "app_sg" {
  name        = "${var.project_name}-app-sg"
  description = "App tier SG"
  vpc_id      = module.aws_vpc.main_vpc.id

  # Inbound: from Web SG only
  ingress {
    description     = "Allow app port from Web SG"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.web_sg.id]
  }

  # Outbound: allow to DB SG only (MySQL)
  egress {
    description     = "Allow MySQL to DB tier"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.db_sg.id]
  }
}

# =============================
# Security Group (DATABASE)
# =============================
resource "aws_security_group" "db_sg" {
  name        = "${var.project_name}-db-sg"
  description = "DB tier SG"
  vpc_id      = aws_vpc.main_vpc.id

  # Inbound: MySQL only from App SG
  ingress {
    description     = "Allow MySQL from App SG"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_sg.id]
  }

  # Outbound: minimal (same SG only)
  # (useful for DNS/healthchecks in some cases; can also be removed)
  egress {
    description = "Allow outbound inside DB SG only"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  tags = {
    Name = "${var.project_name}-db-sg"
    Tier = "db"
  }
}
