resource  "aws_instance"  "os1" {

ami = "ami-010aff33ed5991201"
instance_type = var.aws_instance_type
#vpc_security_group_ids =  aws_vpc.main.id
#subnet_id              = aws_subnet.main[0].id


tags = {
     Name = "os1 of terraform-provisioner"
     }
}

