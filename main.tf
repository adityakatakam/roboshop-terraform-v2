resource "aws_instance" "instance" {
  count = 9
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [var.vpc_security_group_ids]

  tags = {
    name = var.components[count.index]
  }
}

resource "aws_route53_record" "a-records" {
  count = 9
  zone_id = var.zone_id
  name    = "${var.component[count.index]}-dev"
  type    = A
  ttl     = 30
  records = [aws_instance.instances[count.index].private_ip]
}