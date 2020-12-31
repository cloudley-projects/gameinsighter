module "instances" {
  source = "./modules/create_instance"
}
module "rds" {
  source = "./modules/create_rds"
  
}