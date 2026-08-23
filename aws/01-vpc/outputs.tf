output "vpc_id" {
  description = "ID of the lab VPC"
  value       = aws_vpc.lab.id
}

output "vpc_cidr" {
  description = "CIDR block of the lab VPC"
  value       = aws_vpc.lab.cidr_block
}

output "web_public_ip" {
  description = "Public IPv4 address of the web instance"
  value       = aws_instance.web.public_ip
}

output "web_url" {
  description = "HTTP URL for the web instance"
  value       = "http://${aws_instance.web.public_ip}"
}