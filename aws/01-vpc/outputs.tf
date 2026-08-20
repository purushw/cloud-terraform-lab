output "vpc_id" {
  description = "ID of the lab VPC"
  value       = aws_vpc.lab.id
}

output "vpc_cidr" {
  description = "CIDR block of the lab VPC"
  value       = aws_vpc.lab.cidr_block
}

output "public_IP" {
  description = "Public IP for EC2 instance"
  value       = aws_instance.web.public_ip
}