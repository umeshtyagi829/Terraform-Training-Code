provider "aws"{
region = "ap-south-1"
profile = "user1"
}

variable "itype" {
    type = map
    default = {
        dev = "t2.small"
        prod = "t2.large"
        test = "t2.micro"
    }
}

resource  "aws_instance"  "os1" {
ami = "ami-010aff33ed5991201"
instance_type = lookup(var.itype, terraform.workspace)
tags = {
     Name = "os1 of terraform-provisioner"
     }
}








