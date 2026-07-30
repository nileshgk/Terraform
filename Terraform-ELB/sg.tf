# Security group for ELB
resource "aws_security_group" "aws-elb-sg" {
  vpc_id      = aws_vpc.AWS-elb-vpc.id
  name        = "aws-elb-sg"
  description = "security group for elastic load balancer"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "aws-elb-sg"
  }

}

# Security group for EC2 instance
resource "aws_security_group" "AWS-instance" {
  vpc_id      = aws_vpc.AWS-elb-vpc.id
  name        = "AWS-instance"
  description = "Security group for instance"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.aws-elb-sg.id]
  }

  tags = {
    Name = "AWS-instance"
  }

}