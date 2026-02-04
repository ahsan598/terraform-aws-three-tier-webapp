# ==============================
# Multi AZ Mapping with Subnets
# ==============================
locals {
  az_count               = length(var.availability_zones)
  public_subnet_map_web  = zipmap(var.availability_zones, var.public_subnets_web)
  private_subnet_map_app = zipmap(var.availability_zones, var.private_subnets_app)
  private_subnet_map_db  = zipmap(var.availability_zones, var.private_subnets_db)
}
