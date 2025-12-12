provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "strapi_sg_pratyush" {
  name_prefix = "strapi_sg_pratyush-"     
  description = "Allow SSH, Strapi and HTTP ports"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 1337
    to_port     = 1337
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

data "aws_ami" "latest_al2023" {
  owners      = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "strapi_server" {
  ami                    = data.aws_ami.latest_al2023.id
  key_name               = "pratyush_baxla_key"
  instance_type          = "t2.small"
  vpc_security_group_ids = [aws_security_group.strapi_sg_pratyush.id]

  user_data = templatefile("user_data.sh", {
    APP_KEYS            = var.APP_KEYS
    API_TOKEN_SALT      = var.API_TOKEN_SALT
    ADMIN_JWT_SECRET    = var.ADMIN_JWT_SECRET
    TRANSFER_TOKEN_SALT = var.TRANSFER_TOKEN_SALT
    ENCRYPTION_KEY      = var.ENCRYPTION_KEY
    DATABASE_HOST       = var.DATABASE_HOST
    DATABASE_NAME       = var.DATABASE_NAME
    DATABASE_USERNAME   = var.DATABASE_USERNAME
    DATABASE_PASSWORD   = var.DATABASE_PASSWORD
    JWT_SECRET          = var.JWT_SECRET
    docker_image        = var.docker_image
  })

  tags = {
    Name = "Pratyush-Baxla-Strapi-Server"
  }
}
