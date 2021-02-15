variable "aws_region" {
  default = "us-east-2"
}
variable "aws_creds" {
  default = "$HOME/.aws/credentials"
}
variable "rds_password" {
  type = string
  sensitive = true
}