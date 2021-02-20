variable "aws_region" {
  default = "us-east-2"
}
variable "rds_password" {
  type      = string
  sensitive = true
}
variable "main_instance_count" {
}