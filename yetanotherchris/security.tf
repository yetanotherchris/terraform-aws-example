# Security groups and rules
# Docs: https://www.terraform.io/docs/providers/aws/r/security_group.html

# Allow everything (don't do this, it's an example only)
resource "aws_security_group" "yetanotherchris-allow-all" {
  name        = "yetanotherchris-allow-all"
  description = "Allow all inbound traffic"

  vpc_id = "${var.aws_vpc_id}"
}

resource "aws_security_group_rule" "ingress-all" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"          # -1 is All
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.yetanotherchris-allow-all.id}"
}

resource "aws_security_group_rule" "egress-all" {
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.yetanotherchris-allow-all.id}"
}

# RDS: allow port 3306
resource "aws_security_group" "yetanotherchris-rds" {
  name        = "yetanotherchris-rds"
  description = "Allow all inbound traffic"

  vpc_id = "${var.aws_vpc_id}"
}

resource "aws_security_group_rule" "rds-ingress" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.yetanotherchris-rds.id}"
}

resource "aws_security_group_rule" "rds-egress" {
  type        = "egress"
  from_port   = 3306
  to_port     = 3306
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.yetanotherchris-rds.id}"
}

# Elasticache: port 6379. *This must not belong to the VPC and no egress rules?*
resource "aws_security_group" "yetanotherchris-elasticache" {
  name        = "yetanotherchris-elasticache"
  description = "Allow all inbound traffic"
    vpc_id   = "${var.aws_vpc_id}"

}

resource "aws_security_group_rule" "elasticache-ingress" {
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.yetanotherchris-elasticache.id}"
}