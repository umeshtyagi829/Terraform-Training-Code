 resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "myvpc-terraform"
  }
}

output "o1" {
     value = aws_vpc.main.id
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "myigw"
  }
}

resource "aws_subnet" "main" {
  count = length(var.subnet_cidr)
  vpc_id     = aws_vpc.main.id
  cidr_block = element(var.subnet_cidr, count.index)
  availability_zone = element(var.azs, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "mysubnet-${count.index + 1}"
  }
}

  output "o2" {
     value = aws_subnet.main[0].id
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
  count = length(var.subnet_cidr)
  subnet_id      = element(aws_subnet.main.*.id, count.index)
  route_table_id = aws_route_table.example.id
}