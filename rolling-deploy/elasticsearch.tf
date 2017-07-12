# ElasticSearch (including Kibana)
# Docs: https://www.terraform.io/docs/providers/aws/r/elasticsearch_domain.html

resource "aws_elasticsearch_domain" "es" {
  domain_name           = "yetanotherchris"
  elasticsearch_version = "5.3"

  cluster_config {
    instance_type  = "t2.small.elasticsearch"
    instance_count = 1
  }

  ebs_options {
    ebs_enabled = true
    volume_size = 10   # 10gb
  }

  snapshot_options {
    automated_snapshot_start_hour = 23
  }

  tags {
    Domain = "yetanotherchris"
  }

  # TODO: make the IP a variable
  access_policies = <<CONFIG
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "es:*",
            "Principal": "*",
            "Effect": "Allow",
            "Condition": {
                "IpAddress": {
                  "aws:SourceIp": [
                    "0.0.0.0/32"
                    ]
                }
            }
        }
    ]
}
CONFIG
}
