provider "aws" {
  region = "us-east-2"
  shared_credentials_file = "~/aws/credentials"
}

resource "aws_instance" "gi_instance" {
  ami           = "ami-0a91cd140a1fc148a"
  instance_type = "t2.micro"
  security_groups = ["gi-ec2-sg"]
  tags = {
    project = "gameinsighter"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    delete_on_termination = true
    volume_size           = 8
    volume_type           = "gp2"
  }
}