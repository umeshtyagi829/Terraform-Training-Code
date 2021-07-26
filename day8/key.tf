
#Creating Key
resource "tls_private_key" "example" {
  algorithm = "RSA"
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
  depends_on = [
    tls_private_key.example
  ]
}

resource "local_file" "key-file" {
  content  = tls_private_key.example.private_key_pem
  filename = "terraform.pem"
  depends_on = [
    tls_private_key.example,
    aws_key_pair.generated_key
  ]
}