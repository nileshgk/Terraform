resource "aws_instance" "MyEC2Instance" {
  ami           = "ami-08f44e8eca9095668"
  instance_type = "t3.small"

  tags = {
    Name = "my-ec2-instance"
  }
# Injecting the User Data script
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y nginx
              systemctl start nginx
              systemctl enable nginx
              echo "<h1>Successfully deployed Nginx via Terraform!</h1>" > /usr/share/nginx/html/index.html
              EOF

}