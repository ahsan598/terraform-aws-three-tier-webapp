# Define the provider
provider "aws" {
  region = var.region  # AWS region from variables.tf
}

# Call VPC module
module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnets = var.private_subnets
}

# Call EC2 module
module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  key_name          = var.key_name
  ami_id            = var.ami_id
  instance_type     = var.instance_type
}

# Call RDS module
module "rds" {
  source            = "./modules/rds"
  db_name           = var.db_name                    # Corrected to use var.db_name for DB name
  db_subnet_ids     = module.vpc.private_subnet_ids
  db_username       = var.db_username
  db_password       = var.db_password
  db_instance_class = var.db_instance_class

}