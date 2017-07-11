# Application Load Balancer (an ELB with routing)
# Docs: https://www.terraform.io/docs/providers/aws/r/iam_user.html

resource "aws_iam_user" "yetanotherchris-ecs" {
  name = "yetanotherchris-ecs"
  path = "/system/"
}

resource "aws_iam_access_key" "yetanotherchris-ecs" {
  user = "${aws_iam_user.yetanotherchris-ecs.name}"
}


resource "aws_iam_role" "yetanotherchris-ecs" {
  name = "yetanotherchris-ecs"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
