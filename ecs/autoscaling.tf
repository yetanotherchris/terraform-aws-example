# Autoscaling group and launch configurations
# Docs: 
# - https://www.terraform.io/docs/providers/aws/r/launch_configuration.html
# - https://www.terraform.io/docs/providers/aws/r/autoscaling_group.html
# - https://www.terraform.io/docs/providers/aws/r/autoscaling_attachment.html

resource "aws_launch_configuration" "ecs-optimised" {
  name_prefix     = "yetanotherchris-ecs-"
  image_id        = "ami-809f84e6"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.yetanotherchris-allow-all-ecs.id}"]

  user_data = <<EOF
#!/bin/bash
echo ECS_CLUSTER=yetanotherchris >> /etc/ecs/ecs.config
EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "yetanotherchris-ecs" {
  name                 = "yetanotherchris-ecs"
  launch_configuration = "${aws_launch_configuration.ecs-optimised.name}"
  min_size             = 1
  max_size             = 1
  vpc_zone_identifier  = ["${var.aws_subnet_a_id}"]
  load_balancers       = ["${aws_elb.yetanotherchris-ecs.id}"]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = "${aws_autoscaling_group.yetanotherchris-ecs.id}"
  elb                    = "${aws_elb.yetanotherchris-ecs.id}"
}
