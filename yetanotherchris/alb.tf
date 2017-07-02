# Application Load Balancer (an ELB with routing)
# Docs: https://www.terraform.io/docs/providers/aws/r/alb.html

resource "aws_alb" "yetanotherchris" {
  name            = "yetanotherchris"
  internal        = false
  security_groups = ["${aws_security_group.yetanotherchris-allow-all.id}"]
  subnets         = ["${var.aws_subnet_a_id}", "${var.aws_subnet_b_id}"]

  tags {
    Environment = "production"
  }
}

# ALB listener and rules
resource "aws_alb_listener" "yetanotherchris-alb-listener-80" {
  load_balancer_arn = "${aws_alb.yetanotherchris.arn}"
  port              = "80"
  protocol          = "HTTP"

  # todo: certificate ARN for SSL

  default_action {
    target_group_arn = "${aws_alb_target_group.yetanotherchris-group-A.arn}"
    type             = "forward"
  }
}

# Attach two routes to the ALB listener and target group
resource "aws_alb_listener_rule" "yetanotherchris-alb-listener-rule-default" {
  listener_arn = "${aws_alb_listener.yetanotherchris-alb-listener-80.arn}"
  priority     = 1

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.yetanotherchris-group-A.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}

resource "aws_alb_listener_rule" "yetanotherchris-alb-listener-rule-canary" {
  listener_arn = "${aws_alb_listener.yetanotherchris-alb-listener-80.arn}"
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = "${aws_alb_target_group.yetanotherchris-group-A.arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/canary/*"]
  }
}
