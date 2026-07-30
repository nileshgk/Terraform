# 1. Security Group for EC2 Instance
resource "aws_security_group" "aws_ec2_sg" {
  name        = "${var.vpcname}-ec2-sg"
  description = "Security group for application EC2 instance"
  vpc_id      = aws_vpc.AWS_vpc.id

  tags = {
    Name        = "${var.vpcname}-ec2-sg"
    environment = var.vpc_environment
  }

  # Inbound HTTP / App Traffic (Adjust port as needed)
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SSH Access to EC2 (Restrict to your IP in production)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  # Outbound traffic from EC2
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Security Group for RDS MariaDB Instance
resource "aws_security_group" "vpc_aws_mariadb_sg" {
  name        = "${var.vpcname}-mariadb-sg"
  description = "Security group for AWS MariaDB instance"
  vpc_id      = aws_vpc.AWS_vpc.id

  tags = {
    Name        = "${var.vpcname}-mariadb-sg"
    environment = var.vpc_environment
  }

  # Allow MySQL/MariaDB (3306) strictly from the EC2 Security Group
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.aws_ec2_sg.id] 
  }

  # Outbound traffic from RDS
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}