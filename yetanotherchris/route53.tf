# Route 53 zone and records
# Docs: https://www.terraform.io/docs/providers/aws/r/route53_zone.html

resource "aws_route53_zone" "yetanotherchris" {
  name = "yetanotherchris.click"
}

# You will need to update your domain's nameservers to match the ones
# that are created in AWS.
resource "aws_route53_record" "yetanotherchris-www" {
  zone_id        = "${aws_route53_zone.yetanotherchris.zone_id}"
  name           = "www.yetanotherchris.click"
  type           = "A"
  set_identifier = "weighted"

  weighted_routing_policy {
    weight = 60
  }

  alias {
    name                   = "${aws_alb.yetanotherchris.dns_name}"
    zone_id                = "${aws_alb.yetanotherchris.zone_id}"
    evaluate_target_health = true
  }
}
