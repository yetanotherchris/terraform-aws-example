# EC2 instances.
# Docs: 
# - https://www.terraform.io/docs/providers/aws/r/instance.html
# - http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html
# Linux ECS optimised
/* resource "aws_instance" "yetanotherchris-ecs" {
  ami             = "ami-809f84e6"
  instance_type   = "t2.micro"
  subnet_id       = "${var.aws_subnet_a_id}"
  count           = 2
  key_name        = "terraform"
  security_groups = ["${aws_security_group.yetanotherchris-allow-all-ecs.id}"]

  tags {
    Name = "yetanotherchris-${count.index}"
  }
} */

