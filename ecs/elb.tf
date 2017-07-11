# Elastic Load Balancer
# Docs: https://www.terraform.io/docs/providers/aws/r/elb.html

resource "aws_elb" "yetanotherchris-ecs" {
  name               = "yetanotherchris-ecs-elb"
  availability_zones = ["eu-west-1a"]
  subnets = ["${var.aws_subnet_a_id}"]

  #access_logs {
  #  bucket        = "foo"
  #  bucket_prefix = "bar"
  #  interval      = 60
  #}

  listener {
    instance_port     = 5000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:5000/"
    interval            = 30
  }

  #
  # The instances must map exactly to the aws_instance count in instances.tf
  # You can't use count in element() (need to double check this with ELBs):
  # https://github.com/hashicorp/terraform/issues/8684
  #
  instances                   = ["${element(aws_instance.yetanotherchris-ecs.*.id, 0)}", "${element(aws_instance.yetanotherchris-ecs.*.id, 1)}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "yetanotherchris-ecs-elb"
  }
}