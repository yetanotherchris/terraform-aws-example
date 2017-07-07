# Application Load Balancer (an ELB with routing)
# Docs: https://www.terraform.io/docs/providers/aws/r/iam_user.html
# S3 iam: https://aws.amazon.com/blogs/security/writing-iam-policies-how-to-grant-access-to-an-amazon-s3-bucket/

resource "aws_iam_user" "yetanotherchris" {
  name = "yetanotherchris"
  path = "/system/"
}

resource "aws_iam_access_key" "yetanotherchris" {
  user = "${aws_iam_user.yetanotherchris.name}"
}

resource "aws_iam_user_policy" "yetanotherchris" {
  name = "yetanotherchris"
  user = "${aws_iam_user.yetanotherchris.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:ListBucket"],
      "Resource": ["arn:aws:s3:::yetanotherchris"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:GetObject",
        "s3:DeleteObject"
      ],
      "Resource": ["arn:aws:s3:::yetanotherchris/*"]
    }
  ]
}
EOF
}
