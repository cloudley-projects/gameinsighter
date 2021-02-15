module "instance1" {
  source           = "./modules/create_instance"
  region           = var.aws_region
  instance_ami     = "ami-0a91cd140a1fc148a"
  instance_type    = "t2.micro"
  ebs_device_name  = "/dev/sda1"
  ebs_vol_size     = 10
  instance_sec_grp = ["sg-0c8cacb1e1be2d217"]
  ebs_vol_type     = "gp2"
  ec2_key_name     = "gikp"
}

module "instance2" {
  source           = "./modules/create_instance"
  region           = var.aws_region
  instance_ami     = "ami-0a91cd140a1fc148a"
  instance_type    = "t2.micro"
  ebs_device_name  = "/dev/sda1"
  ebs_vol_size     = 10
  instance_sec_grp = ["sg-0c8cacb1e1be2d217"]
  ebs_vol_type     = "gp2"
  ec2_key_name     = "gikp"
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
  source = "./modules/create_lb"
  region           = var.aws_region
  gi_instances_id = [module.instance1.gi_instance_id,module.instance2.gi_instance_id]
}