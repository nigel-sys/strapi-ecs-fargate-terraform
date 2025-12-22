provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "strapi_sg_pratyush" {
  name        = "pratyush-baxla-strapi-sg"
  description = "Allow HTTP access to Strapi running on ECS Fargate"

  ingress {
    description     = "Allow Strapi traffic"
    from_port       = 1337
    to_port         = 1337
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
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

  tags = {
    Name = "pratyush-baxla-strapi-sg"
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "public_1b" {
  id = "subnet-0dcf98e23a5861550"
}

resource "aws_subnet" "pratyush_private_1b" {
  vpc_id                  = data.aws_vpc.default.id
  cidr_block              = "172.31.220.0/24"
  availability_zone       = "ap-south-1b"
  map_public_ip_on_launch = false

  tags = {
    Name  = "pratyush-private-1b"
    Owner = "pratyush"
  }
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "pratyush_nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = data.aws_subnet.public_1b.id

  tags = {
    Name  = "pratyush-nat"
    Owner = "pratyush"
  }
}

resource "aws_route_table" "pratyush_private_rt" {
  vpc_id = data.aws_vpc.default.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.pratyush_nat.id
  }

  tags = {
    Name  = "pratyush-private-rt"
    Owner = "pratyush"
  }
}

resource "aws_route_table_association" "pratyush_private_assoc" {
  subnet_id      = aws_subnet.pratyush_private_1b.id
  route_table_id = aws_route_table.pratyush_private_rt.id
}
