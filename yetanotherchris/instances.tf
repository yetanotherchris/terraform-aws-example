# EC2 instances.
# Docs: https://www.terraform.io/docs/providers/aws/r/instance.html

# Windows 2016 base
resource "aws_instance" "yetanotherchris" {
  ami             = "ami-2d809e4b"
  instance_type   = "t2.micro"
  subnet_id       = "${var.aws_subnet_a_id}"
  count           = 2
  key_name        = "terraform"
  user_data       = "${file("./yetanotherchris/userdata.txt")}"
  security_groups = ["${aws_security_group.yetanotherchris-allow-all.id}"]

  tags {
    Name = "yetanotherchris-${count.index}"
  }
}
