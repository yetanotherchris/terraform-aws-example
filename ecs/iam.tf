# Application Load Balancer (an ELB with routing)
# Docs: 
# - https://www.terraform.io/docs/providers/aws/r/iam_user.html
# - https://www.terraform.io/docs/providers/aws/r/iam_role.html
# - https://www.terraform.io/docs/providers/aws/r/iam_policy_attachment.html

resource "aws_iam_user" "yetanotherchris-ecs" {
  name = "yetanotherchris-ecs"
  path = "/system/"
}

resource "aws_iam_access_key" "yetanotherchris-ecs" {
  user = "${aws_iam_user.yetanotherchris-ecs.name}"
}

resource "aws_iam_role" "yetanotherchris-ecs" {
  name = "yetanotherchris-ecs"

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

# Attach a policy to the role.
# This is admin access to ECS, change this on production.
resource "aws_iam_policy_attachment" "yetanotherchris-ecs" {
  name       = "yetanotherchris-ecs"
  users      = ["${aws_iam_user.yetanotherchris-ecs.name}"]
  roles      = ["${aws_iam_role.yetanotherchris-ecs.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}