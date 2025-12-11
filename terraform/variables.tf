variable "docker_image" {
  type    = string
  default = "301782007642.dkr.ecr.ap-south-1.amazonaws.com/pratyush_baxla/strapi-app:pratyush_nigel_baxla"
}

variable "APP_KEYS" { type = string }
variable "API_TOKEN_SALT" { type = string }
variable "ADMIN_JWT_SECRET" { type = string }
variable "TRANSFER_TOKEN_SALT" { type = string }
variable "ENCRYPTION_KEY" { type = string }

variable "DATABASE_HOST" { type = string }
variable "DATABASE_NAME" { type = string }
variable "DATABASE_USERNAME" { type = string }
variable "DATABASE_PASSWORD" { type = string }

variable "JWT_SECRET" { type = string }
