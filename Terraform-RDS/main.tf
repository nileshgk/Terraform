# AWS PROVIDER CONFIGURATION
provider "aws" {
  region = var.region
}

# resource Key pair for Jenkins EC2 instance
resource "aws_key_pair" "aws_key_pair" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# RDS EC2 Instance
resource "aws_instance" "aws_EC2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.aws_key_pair.key_name
  subnet_id     = aws_subnet.AWS_pub_subnet1.id
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.aws_ec2_sg.id]
  
  tags = {
    Name        = "aws-EC2"
    environment = var.vpc_environment
  }
}
