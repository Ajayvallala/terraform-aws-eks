module "vpc" {
  source                = "git::https://github.com/Ajayvallala/terraform-aws-vpc.git?ref=main"
  project               = var.project
  env                   = var.env
  public_subnet_cidrs   = var.public_subnet_cidrs
  private_subnet_cidrs  = var.private_subnet_cidrs
  database_subnet_cidrs = var.database_subnet_cidrs
  is_peering_required   = var.is_peering_required

}