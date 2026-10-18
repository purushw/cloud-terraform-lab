# Expose the VPC identifier for inspection or later integrations.
output "vpc_id" {
  description = "ID of the lab VPC"
  value       = aws_vpc.lab.id
}

# Show the address space actually assigned to the VPC.
output "vpc_cidr" {
  description = "CIDR block of the lab VPC"
  value       = aws_vpc.lab.cidr_block
}

# Make the web instance's public address easy to find after deployment.
output "web_public_ip" {
  description = "Public IPv4 address of the web instance"
  value       = aws_instance.web.public_ip
}

# Provide a direct HTTP address for checking the web server.
output "web_url" {
  description = "HTTP URL for the web instance"
  value       = "http://${aws_instance.web.public_ip}"
}