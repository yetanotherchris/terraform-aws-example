# Elasticcache (Redis)
# Docs: 
# - https://www.terraform.io/docs/providers/aws/r/elasticache_cluster.html
# - https://www.terraform.io/docs/providers/aws/r/elasticache_security_group.html
# - https://www.terraform.io/docs/providers/aws/r/elasticache_subnet_group.html

resource "aws_elasticache_cluster" "yetanotherchris" {
  cluster_id           = "yetanotherchris"
  engine               = "redis"
  node_type            = "cache.t2.micro"
  port                 = 6379
  num_cache_nodes      = 1
  parameter_group_name = "default.redis3.2"
  security_group_ids   = ["${aws_security_group.yetanotherchris-elasticache.id}"]
  subnet_group_name    = "${aws_elasticache_subnet_group.yetanotherchris.name}"
}

resource "aws_elasticache_security_group" "yetanotherchris" {
  name                 = "yetanotherchris"
  security_group_names = ["${aws_security_group.yetanotherchris-elasticache.name}"]
}

resource "aws_elasticache_subnet_group" "yetanotherchris" {
  name       = "yetanotherchris"
  subnet_ids = ["subnet-ebf69d9d"]
}
