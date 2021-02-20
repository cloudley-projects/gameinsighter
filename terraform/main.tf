terraform {
  backend "s3" {
    bucket = "gameinsighter-bucket"
    key    = "state/gi-tf-state"
    region = "us-east-2"
  }
}

module "rds" {
  source                  = "./modules/create_rds"
  region                  = var.aws_region
  rds_sec_grp             = "gi-rds-sg"
  rds_engine              = "mysql"
  rds_eng_version         = "8.0.20"
  rds_identifier          = "gameinsighterdb"
  rds_username            = "giadmin"
  rds_password            = var.rds_password
  rds_instance_class      = "db.t2.micro"
  rds_allocated_storage   = 20
  rds_availability_zone   = "us-east-2a"
  rds_subnet_group_name   = "default-vpc-229b2249"
  rds_publicly_accessible = true
  rds_db_name             = "gameinsighterdb"
  rds_skip_final_snapshot = true
  rds_port                = 3306
}

module "load_balancer" {
  source          = "./modules/create_lb"
  region          = var.aws_region
  gi_instances_id = module.gi_instances.instance_id
}

module "gi_instances" {
  source        = "./modules/create_instances"
  gi_ins_count =var.main_instance_count
  region        = var.aws_region
  gi_ins_ami  = "ami-0a91cd140a1fc148a"
  gi_ins_type = "t2.micro"
  gi_key_name  = "gikp"
  gi_ins_sec_grp = "gi-ec2-sg"
  gi_root_vol_size     = 8
  gi_root_vol_type     = "gp2"
  user_data_path ="./user_data.sh"
  user_data_variables={}
}
