resource "aws_ecs_cluster_capacity_providers" "strapi" {
  cluster_name = aws_ecs_cluster.strapi.name

  capacity_providers = ["FARGATE_SPOT"]

  default_capacity_provider_strategy {
    capacity_provider = "FARGATE_SPOT"
    weight            = 1
  }

}
