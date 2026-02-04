# VPC module
module "aws_vpc" {
  source              = "./modules/networking"
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
  public_subnets_web  = var.public_subnets_web
  private_subnets_app = var.private_subnets_app
  private_subnets_db  = var.private_subnets_db
}
