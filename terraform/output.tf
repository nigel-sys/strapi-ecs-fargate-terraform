output "alb_dns_name" {
  description = "The DNS name of the Strapi ALB"
  value       = aws_lb.strapi_alb.dns_name
}

output "rds_endpoint" {
  value = aws_db_instance.strapi_db.address
}