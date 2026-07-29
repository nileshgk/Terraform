resource "aws_key_pair" "my_key_pair-ec2" {
  key_name   = "my_local_key-ec2"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_instance" "MyEC2Instance" {
  ami           = "ami-08f44e8eca9095668"
  instance_type = "t3.small"
  key_name      = aws_key_pair.my_key_pair-ec2.key_name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  subnet_id = aws_subnet.public_subnet-1.id

  tags = {
    Name = "my-ec2-instance"
  }
# Injecting the User Data script
  user_data = file("installNginx.sh")
}

#output the public IP of the instance
output "ec2_instance_public_ip" {
  value = aws_instance.MyEC2Instance.public_ip
}