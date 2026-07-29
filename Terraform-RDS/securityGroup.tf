# AWS Security Group for MariaDB VPC
resource "aws_security_group" "vpc_aws_mariadb_sg" {
  name        = "${var.vpcname}-sg"
  description = "Security group for AWS MariaDB instance"
  vpc_id      = aws_vpc.AWS_vpc.id
  tags = {
    Name        = "${var.vpcname}-sg"
    environment = var.vpc_environment
  }
# Allow inbound traffic on port 22 for SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
# Allow inbound traffic on port 3306 for MySQL/MariaDB
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.vpc_aws_mariadb_sg.id]
  }
# Allow outbound traffic to all destinations
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}