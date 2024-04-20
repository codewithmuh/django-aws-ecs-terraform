resource "aws_elasticache_cluster" "redis" {
  cluster_id           = var.cluster_id
  engine               = var.engine
  engine_version       = var.engine_version
  node_type            = var.node_type
  num_cache_nodes      = var.num_cache_nodes
  port                 = var.port
  parameter_group_name = aws_elasticache_parameter_group.default.name
  subnet_group_name    = aws_elasticache_subnet_group.subnet_group.name
}

resource "aws_elasticache_subnet_group" "subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids # Replace with your actual subnet IDs
}

resource "aws_elasticache_parameter_group" "default" {
  name   = "cache-params"
  family = "redis5.0"

  parameter {
    name  = "activerehashing"
    value = "yes"
  }


}