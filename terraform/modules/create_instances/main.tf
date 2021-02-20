provider "aws" {
  region = var.region
}
data "aws_security_group" "sec_grp" {
  name = var.gi_ins_sec_grp
}

resource "aws_instance" "instance" {
count =2
ami     = var.gi_ins_ami
instance_type = var.gi_ins_type
key_name = var.gi_key_name
vpc_security_group_ids = [data.aws_security_group.sec_grp.id]
user_data = templatefile(var.user_data_path, var.user_data_variables)
tags = {
    project = "gameinsighter"
  }
  root_block_device {
    delete_on_termination = true
    volume_size           = var.gi_root_vol_size
    volume_type           = var.gi_root_vol_type
  }
}