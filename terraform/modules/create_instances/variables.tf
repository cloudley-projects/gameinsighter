variable "region" {
  default = "us-east-2"
}
variable "gi_ins_type" {
  default = "t2.micro"
}
variable "gi_ins_count" {}
variable "gi_ins_ami" {}
variable "gi_key_name" {}
variable "gi_ins_sec_grp" {}
variable "gi_root_vol_size" {}
variable "gi_root_vol_type" {}
variable "user_data_path"{}
variable "user_data_variables" {}