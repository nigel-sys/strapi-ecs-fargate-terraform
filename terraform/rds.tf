resource "aws_security_group" "rds_sg" {
  name        = "strapi_rds_sg"
  description = "Allow PostgreSQL access from EC2 only"

  ingress {
    description     = "PostgreSQL Access from EC2"
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
}

resource "aws_db_instance" "strapi_db" {
  identifier              = "pratyush-baxla-strapi-postgres-db"
  allocated_storage       = 20
  engine                  = "postgres"
  engine_version          = "18.1-R1"
  instance_class          = "db.t4g.micro"

  db_name                 = var.DATABASE_NAME
  username                = var.DATABASE_USERNAME
  password                = var.DATABASE_PASSWORD
  port                    = 5432
  publicly_accessible     = false
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
}
