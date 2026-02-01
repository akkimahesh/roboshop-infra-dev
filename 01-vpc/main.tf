module "roboshop" {
  source                = "git::https://github.com/akkimahesh/terraform-aws-vpc.git?ref=main"
  common_tags           = var.common_tags
  vpc_tags              = var.vpc_tags
  project_name          = var.project_name
  environment           = var.environment
  public_subnets_cidr   = var.public_subnets_cidr
  private_subnets_cidr  = var.private_subnets_cidr
  database_subnets_cidr = var.database_subnets_cidr
  is_peering_required = var.is_peering_required
}




