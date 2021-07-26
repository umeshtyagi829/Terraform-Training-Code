provider "aws" {
  region  = var.aws_region
  profile = "arth"
}

#Creating VPC 
resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "myvpc"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "myigw"
  }
}
resource "aws_subnet" "main" {
  count                   = length(var.subnet_cidr)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.subnet_cidr, count.index)
  availability_zone       = element(var.azs, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "mysubnet-${count.index + 1}"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "routetable"
  }
}

resource "aws_route_table_association" "a" {
  count          = length(var.subnet_cidr)
  subnet_id      = element(aws_subnet.main.*.id, count.index)
  route_table_id = aws_route_table.example.id
}

#Creating Security Group
resource "aws_security_group" "allow_ports" {
  name        = "terraform_sg"
  description = "Allow inbound traffic"
  vpc_id      = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.sgports
    content {
      description = "SHH, HTTP from VPC"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#Launch EC2 for Apache Httpd, Python, Flask, MongoDB
resource "aws_instance" "os1" {
  ami             = "ami-010aff33ed5991201"
  instance_type   = var.aws_instance_type
  subnet_id       = aws_subnet.main[0].id
  security_groups = [aws_security_group.allow_ports.id]
  key_name        = "awskey"
  user_data       = file("./install_jenkins.sh")

  tags = {
    Name = "Jenkins"
  }
}

output "ip" {
  value = aws_instance.os1.public_ip
}