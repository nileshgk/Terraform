# Launch Template
resource "aws_launch_template" "aws-elb-launchtemplate" {
  name_prefix   = "aws-elb-launchtemplate"
  image_id      = lookup(var.AMIS, var.region)
  instance_type = "t3.micro"

  key_name = aws_key_pair.keyPublic.key_name

  vpc_security_group_ids = [
    aws_security_group.AWS-instance.id
  ]

  user_data = base64encode(<<-EOF
#!/bin/bash

# Update system
dnf update -y

# Install Nginx
dnf install -y nginx

# Enable and start Nginx
systemctl enable nginx
systemctl start nginx

# Get IMDSv2 token
TOKEN=$(curl -X PUT "http://169.254.169.254/latest/api/token" \
-H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

# Get private IP
INSTANCE_IP=$(curl -H "X-aws-ec2-metadata-token: $TOKEN" \
http://169.254.169.254/latest/meta-data/local-ipv4)

# Create web page
cat > /usr/share/nginx/html/index.html <<HTML
<!DOCTYPE html>
<html>
<head>
    <title>Terraform ELB Demo</title>
</head>
<body style="font-family: Arial; text-align:center; margin-top:50px;">
    <h1>Hello from Amazon Linux 2023!</h1>
    <h2>Served by Auto Scaling Group</h2>
    <p><strong>Private IP:</strong> $INSTANCE_IP</p>
</body>
</html>
HTML

# Restart Nginx
systemctl restart nginx
EOF
  )

  lifecycle {
    create_before_destroy = true
  }
}

# Key Pair
resource "aws_key_pair" "keyPublic" {
  key_name   = "keyPublic"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

# Auto Scaling Group
resource "aws_autoscaling_group" "aws-elb-asg" {
  name = "aws-elb-asg"

  vpc_zone_identifier = [
    aws_subnet.elb-public-subnet1.id,
    aws_subnet.elb-public-subnet2.id
  ]

  min_size = 2
  max_size = 3

  health_check_grace_period = 200
  health_check_type         = "ELB"

  load_balancers = [
    aws_elb.my-aws-elb.id
  ]

  force_delete = true

  launch_template {
    id      = aws_launch_template.aws-elb-launchtemplate.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "AWS EC2 Instance via ELB"
    propagate_at_launch = true
  }
}