resource "aws_ecs_cluster" "strapi" {
  name = "pratyush-baxla-strapi-cluster"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

resource "aws_cloudwatch_log_group" "strapi" {
  name = "/ecs/pratyush-baxla-strapi"
  retention_in_days = 7
}

resource "aws_ecs_task_definition" "strapi" {
  family                   = "pratyush-baxla-strapi-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"
  execution_role_arn       = aws_iam_role.pratyush-baxla-ecs_execution_role.arn
  task_role_arn            = aws_iam_role.pratyush_baxla_ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "strapi"
      image     = var.docker_image
      essential = true

      portMappings = [
        {
          containerPort = 1337
          protocol      = "tcp"
        }
      ]

      environment = [
      { name = "HOST", value = "0.0.0.0" },
      { name = "PORT", value = "1337" },
      { name = "NODE_ENV", value = "production" },

      { name = "APP_KEYS", value = var.APP_KEYS },
      { name = "API_TOKEN_SALT", value = var.API_TOKEN_SALT },
      { name = "ADMIN_JWT_SECRET", value = var.ADMIN_JWT_SECRET },
      { name = "TRANSFER_TOKEN_SALT", value = var.TRANSFER_TOKEN_SALT },
      { name = "ENCRYPTION_KEY", value = var.ENCRYPTION_KEY },

      { name = "DATABASE_CLIENT", value = "postgres" },
      { name = "DATABASE_HOST", value = aws_db_instance.strapi_db.address },
      { name = "DATABASE_PORT", value = "5432" },
      { name = "DATABASE_NAME", value = var.DATABASE_NAME },
      { name = "DATABASE_USERNAME", value = var.DATABASE_USERNAME },
      { name = "DATABASE_PASSWORD", value = var.DATABASE_PASSWORD },
      { name = "DATABASE_SSL", value = "true" },
      { name = "DATABASE_SSL_REJECT_UNAUTHORIZED", value = "false" },

      { name = "JWT_SECRET", value = var.JWT_SECRET }
    ]

      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.strapi.name
          awslogs-region        = "ap-south-1"
          awslogs-stream-prefix = "ecs"
        }
      }
    }
  ])
}

resource "aws_ecs_service" "strapi" {
  name            = "pratyush-baxla-strapi-service"
  cluster         = aws_ecs_cluster.strapi.id
  task_definition = aws_ecs_task_definition.strapi.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets         = data.aws_subnets.default.ids
    security_groups = [aws_security_group.strapi_sg_pratyush.id]
    assign_public_ip = true
  }

  depends_on = [
    aws_ecs_task_definition.strapi
  ]
}
