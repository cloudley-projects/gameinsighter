provider "aws" {
  region                  = var.region
}
data "aws_vpc" "selected" {
  id = "vpc-229b2249"
}

data "aws_security_group" "gi_lb_sg" {
  name = "gi-load-balancer"
}

resource "aws_lb" "gi_lb" {
  internal = false
  load_balancer_type = "application"
  security_groups    = [data.aws_security_group.gi_lb_sg.id]
  subnets = [ "subnet-947bdaff","subnet-028b9478","subnet-042a6c48" ]
}

resource "aws_lb_listener" "gi_http_listener" {
  load_balancer_arn = aws_lb.gi_lb.arn
  port              = "80"
  protocol          = "HTTP"

default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.gi_lb_tg.arn
  }
}

resource "aws_lb_target_group" "gi_lb_tg" {
  name = "gitg"
  port = 80
  protocol = "HTTP"
  vpc_id= data.aws_vpc.selected.id

}

resource "aws_lb_target_group_attachment" "gi_tg_instances" {
  count = length(var.gi_instances_id)
  target_group_arn = aws_lb_target_group.gi_lb_tg.arn
  target_id        = var.gi_instances_id[count.index]
  port             = 80
}