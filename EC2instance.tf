resource "aws_instance" "MyEC2Instance" {
  ami           = "ami-08f44e8eca9095668"
  instance_type = "t3.small"

  tags = {
    Name = "my-ec2-instance"
  }
}