/*provider "aws"{
region = "ap-south-1"
profile = "user1"

}

variable "sgports"{
    type = list
    default = [80, 22, 443, 5000]
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
      for_each = var.sgports
      content{
        description      = "TLS from VPC"
        from_port        = ingress.value
        to_port          = ingress.value
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
      }
  }
}*/