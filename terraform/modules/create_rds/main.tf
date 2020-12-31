provider "aws" {
  region = "us-east-2"
  shared_credentials_file = "~/aws/credentials"
}

data "aws_security_group" "gi_rds_sg" {
    name = "gi-rds-sg"
}
# Create db instance 1
resource "aws_db_instance" "gi_db_instance" {
  engine = "mysql"
  engine_version = "8.0.20"
  identifier = "gameinsighterdb"
  username = "giadmin"
  password = "SQL$9mhp"
  instance_class = "db.t2.micro"
  allocated_storage = 20
  availability_zone = "us-east-2a"
  db_subnet_group_name = "default-vpc-229b2249"
  publicly_accessible = true
  vpc_security_group_ids = [ data.aws_security_group.gi_rds_sg.id ]
  name = "gameinsighterdb"
  skip_final_snapshot = true
  port = 3306
  
}