resource "aws_security_group" "ecs_sg" {
  name        = "pratyush-baxla-strapi_ecs_sg"
  description = "Allow ECS tasks outbound access"  

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "pratyush-baxla-strapi-ecs-sg"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "pratyush-baxla-strapi_rds_sg"
  description = "Allow PostgreSQL access from ECS tasks"

  ingress {
    description     = "PostgreSQL access from ECS tasks"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.strapi_sg_pratyush.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "pratyush-baxla-strapi-rds-sg"
  }
}

# PostgreSQL RDS instance
resource "aws_db_instance" "strapi_db" {
  identifier              = "pratyush-baxla-strapi-postgres-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "15.7"
  instance_class          = "db.t3.micro"

  db_name                 = var.DATABASE_NAME
  username                = var.DATABASE_USERNAME
  password                = var.DATABASE_PASSWORD
  port                    = 5432
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true

  tags = {
    Name = "pratyush-baxla-strapi-db"
  }
}

output "rds_endpoint" {
  value = aws_db_instance.strapi_db.address
}
