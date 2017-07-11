# ALB target group + instance to target group mapping
# Docs: https://www.terraform.io/docs/providers/aws/r/alb_target_group.html

resource "aws_alb_target_group" "yetanotherchris-ecs" {
  name     = "yetanotherchris-group-ecs"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "${var.aws_vpc_id}"
}

#
# The attachments must map exactly to the aws_instance count in instances.tf
# You can't use count in element():
# https://github.com/hashicorp/terraform/issues/8684
#
resource "aws_alb_target_group_attachment" "yetanotherchris-ecs" {
  target_group_arn = "${aws_alb_target_group.yetanotherchris-ecs.arn}"
  target_id        = "${element(aws_instance.yetanotherchris-ecs.*.id, 0)}"
  port             = 80
}
