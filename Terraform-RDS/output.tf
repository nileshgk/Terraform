output "_instance_public_ip" {
  value = aws_instance.aws_EC2.public_ip
}


output "aws_instance_id" {
  value       = aws_instance.aws_EC2.id
  description = "The ID of the aws EC2 instance"
}

output "vpc_id" {
  value       = aws_vpc.AWS_vpc.id
  description = "The ID of the VPC"
}

output "security_group_id" {
  value       = aws_security_group.vpc_aws_mariadb_sg.id
  description = "The ID of the security group for the MariaDB RDS instance"
}

output "public_subnet1_id" {
  value       = aws_subnet.AWS_pub_subnet1.id
  description = "The ID of the first public subnet"
}

output "public_subnet2_id" {
  value       = aws_subnet.AWS_pub_subnet2.id
  description = "The ID of the second public subnet"
}

output "private_subnet1_id" {
  value       = aws_subnet.AWS_pvt_subnet1.id
  description = "The ID of the first private subnet"
}

output "private_subnet2_id" {
  value       = aws_subnet.AWS_pvt_subnet2.id
  description = "The ID of the second private subnet"
}

output "db_instance_endpoint" {
  value       = aws_db_instance.mariadb.endpoint
  description = "The endpoint of the MariaDB RDS instance"
}

