# Create EC2 instances in the specified subnets
resource "aws_instance" "web" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.public_subnet_ids[0]

  tags = {
    Name = "WebServer-${count.index + 1}"
  }

  count = length(var.public_subnet_ids) # Create one instance per subnet
}

# Security group for EC2
resource "aws_security_group" "web_sg" {
  vpc_id      = var.vpc_id
  description = "Security group for web server allowing TLS and SSH traffic"

  tags = {
    Name = "WebServer-SG"
  }
}

resource "aws_security_group_rule" "http_ingress" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
  description       = "Allow HTTP traffic"
}

resource "aws_security_group_rule" "ssh_ingress" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
  description       = "Allow SSH traffic"
}

resource "aws_security_group_rule" "all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.web_sg.id
  description       = "Allow all outbound traffic"
}