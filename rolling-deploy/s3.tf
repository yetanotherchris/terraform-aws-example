# S3 buckets

# Docs: 
# - https://www.terraform.io/docs/providers/aws/r/s3_bucket.html
# - https://www.terraform.io/docs/providers/aws/r/s3_bucket_object.html
# - https://www.terraform.io/docs/providers/aws/r/s3_bucket_policy.html

resource "aws_s3_bucket" "yetanotherchris" {
  bucket = "yetanotherchris"
  acl    = "private"

  tags {
    Name        = "yetanotherchris"
    Environment = "Dev"
  }

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "PublicReadForGetTestBucketObjects",
            "Effect": "Allow",
            "Principal": {
                "AWS": "*"
            },
            "Action": "s3:GetObject",
            "Resource": "arn:aws:s3:::yetanotherchris/*"
        },
        {
            "Sid": "",
            "Effect": "Allow",
            "Principal": {
                "AWS": "${aws_iam_user.yetanotherchris.arn}"
            },
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::yetanotherchris",
                "arn:aws:s3:::yetanotherchris/*"
            ]
        }
    ]
}
EOF
}
