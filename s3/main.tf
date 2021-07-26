provider "aws" {
    region = "ap-south-1"
    profile = "arth"
}

variable "bname" {
    default = "mybucket1041"
  
}

resource "aws_s3_bucket" "b" {
  bucket = var.bname
  acl    = "private"
  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "object" {
  bucket = var.bname
  key    = "you.jpg"
  source = "C:/Users/umesh/OneDrive/Pictures/Saved Pictures/me.jpg"
  etag = filemd5("C:/Users/umesh/OneDrive/Pictures/Saved Pictures/me.jpg")
}