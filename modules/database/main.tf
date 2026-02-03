# Create an RDS instance
resource "aws_db_instance" "db" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = var.db_instance_class
  db_name              = var.db_name
  username             = var.db_username
  password             = var.db_password
  publicly_accessible  = false
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

  tags = {
    Name = "RDS-DB"
  }
}

# Create a DB subnet group
resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db-subnet-group"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "RDS DB Subnet Group"
  }
}