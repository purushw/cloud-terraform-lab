resource "aws_vpc" "lab" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "cloud-terraform-lab-vpc"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id            = aws_vpc.lab.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "eu-west-2a"

  tags = {
    Name = "cloud-terraform-lab-public-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id            = aws_vpc.lab.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "eu-west-2b"

  tags = {
    Name = "cloud-terraform-lab-public-2"
  }
}

resource "aws_internet_gateway" "lab" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name = "cloud-terraform-lab-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.lab.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lab.id
  }

  tags = {
    Name = "cloud-terraform-lab-public-rt"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "web" {
  name        = "cloud-terraform-lab-web-sg"
  description = "Allow HTTP traffic to lab EC2 instance"
  vpc_id      = aws_vpc.lab.id

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "cloud-terraform-lab-web-sg"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.public_1.id
  vpc_security_group_ids      = [aws_security_group.web.id]
  associate_public_ip_address = true

  tags = {
    Name = "cloud-terraform-lab-web"
  }

  user_data = <<-EOF
  #!/bin/bash
  dnf install -y httpd
  systemctl enable httpd
  systemctl start httpd
  echo "Hello from Terraform on AWS" > /var/www/html/index.html
EOF

}