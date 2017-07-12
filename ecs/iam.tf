# IAM users, roles for ECS
# Docs: 
# - https://www.terraform.io/docs/providers/aws/r/iam_user.html
# - https://www.terraform.io/docs/providers/aws/r/iam_role.html
# - https://www.terraform.io/docs/providers/aws/r/iam_policy_attachment.html
# - http://docs.aws.amazon.com/elasticloadbalancing/latest/userguide/load-balancer-authentication-access-control.html#elb-iam-policies

resource "aws_iam_user" "yetanotherchris-ecs" {
  name = "yetanotherchris-ecs"
  path = "/system/"
}

resource "aws_iam_access_key" "yetanotherchris-ecs" {
  user = "${aws_iam_user.yetanotherchris-ecs.name}"
}

resource "aws_iam_role" "yetanotherchris-ecs" {
  name = "yetanotherchris-ecs"

  # This is required to solve this bug: https://github.com/hashicorp/terraform/issues/2761
  lifecycle {
    create_before_destroy = true
  }

  # Use ecs.amazonaws not ec2.amazonaws for the principal
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

# Attach policies to the role.

# This is admin access to ECS and EC2, change this on production.
resource "aws_iam_policy_attachment" "yetanotherchris-ecs" {
  name       = "yetanotherchris-ecs"
  users      = ["${aws_iam_user.yetanotherchris-ecs.name}"]
  roles      = ["${aws_iam_role.yetanotherchris-ecs.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

resource "aws_iam_policy_attachment" "yetanotherchris-loadbalancer" {
  name       = "yetanotherchris-loadbalancer"
  users      = ["${aws_iam_user.yetanotherchris-ecs.name}"]
  roles      = ["${aws_iam_role.yetanotherchris-ecs.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_policy_attachment" "yetanotherchris-autoscale" {
  name       = "yetanotherchris-autoscale"
  users      = ["${aws_iam_user.yetanotherchris-ecs.name}"]
  roles      = ["${aws_iam_role.yetanotherchris-ecs.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceAutoscaleRole"
}