terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.1"
    }
  }
}
resource "aws_instance" "instance" {
  count = 9
  ami = "var.ami"
  instance_type = "var.instance_type"
  vpc_security_group_ids = [var.vpc_security_group_ids]

  tags = {
    name = var.components[count.index]
  }
}

resource "aws_route53_record" "a-records" {
  count = 9
  name    = "${var.component{count.index]}-dev"
  type    = "A"
  zone_id = "var.zone_id"
  ttl     = 30
  records = [aws_instance.instances[count.index].private_ip]
}