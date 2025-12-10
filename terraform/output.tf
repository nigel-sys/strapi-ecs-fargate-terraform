output "strapi_public_ip" {
  value = aws_instance.strapi_server.public_ip
}

output "strapi_url" {
  value = "http://${aws_instance.strapi_server.public_ip}/admin"
}
