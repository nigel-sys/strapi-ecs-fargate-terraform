# resource "aws_cloudwatch_metric_alarm" "strapi_cpu_high" {
#   alarm_name          = "pratyush-baxla-strapi-high-cpu"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = 2
#   metric_name         = "CPUUtilization"
#   namespace           = "AWS/ECS"
#   period              = 60
#   statistic           = "Average"
#   threshold           = 75

#   dimensions = {
#     ClusterName = aws_ecs_cluster.strapi.name
#     ServiceName = aws_ecs_service.strapi.name
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "strapi_memory_high" {
#   alarm_name          = "pratyush-baxla-strapi-high-memory"
#   comparison_operator = "GreaterThanThreshold"
#   evaluation_periods  = 2
#   metric_name         = "MemoryUtilization"
#   namespace           = "AWS/ECS"
#   period              = 60
#   statistic           = "Average"
#   threshold           = 80

#   dimensions = {
#     ClusterName = aws_ecs_cluster.strapi.name
#     ServiceName = aws_ecs_service.strapi.name
#   }
# }

# resource "aws_cloudwatch_metric_alarm" "strapi_task_health" {
#   alarm_name          = "pratyush-baxla-strapi-task-health-check"
#   comparison_operator = "LessThanThreshold"
#   evaluation_periods  = 1
#   metric_name         = "RunningTaskCount"
#   namespace           = "AWS/ECS"
#   period              = 60
#   statistic           = "Minimum"
#   threshold           = 1

#   dimensions = {
#     ClusterName = aws_ecs_cluster.strapi.name
#     ServiceName = aws_ecs_service.strapi.name
#   }
# }
