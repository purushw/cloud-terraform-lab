resource "aws_vpc" "lab" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "cloud-terraform-lab-vpc"
  }
}

resource "aws_subnet" "public" {
  for_each = var.public_subnets

  vpc_id            = aws_vpc.lab.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = "cloud-terraform-lab-${each.key}"
  }
}

moved {
  from = aws_subnet.public_1
  to   = aws_subnet.public["public_1"]
}

moved {
  from = aws_subnet.public_2
  to   = aws_subnet.public["public_2"]
}

resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id            = aws_vpc.lab.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  tags = {
    Name = "cloud-terraform-lab-${each.key}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.lab.id

  tags = {
    Name = "cloud-terraform-lab-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
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

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

moved {
  from = aws_route_table_association.public_1
  to   = aws_route_table_association.public["public_1"]
}

moved {
  from = aws_route_table_association.public_2
  to   = aws_route_table_association.public["public_2"]
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
  subnet_id                   = aws_subnet.public["public_1"].id
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

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "cloud-terraform-lab-nat-eip"
  }
}
