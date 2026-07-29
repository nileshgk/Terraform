#create AWS VPC 
resource "aws_vpc" "vpc_ec2" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true


  tags = {
    Name = "vpc_ec2"
  }
}

#create AWS Subnets
resource "aws_subnet" "public_subnet-1" {
  vpc_id     = aws_vpc.vpc_ec2.id
  cidr_block = "10.0.0.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
    Name = "public_subnet-1"
  }
}
resource "aws_subnet" "public_subnet-2" {
  vpc_id     = aws_vpc.vpc_ec2.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "public_subnet-2"
  }
}
resource "aws_subnet" "private_subnet-1" {
  vpc_id     = aws_vpc.vpc_ec2.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone = "us-east-1a"
  tags = {
    Name = "private_subnet-1"
  }
}
resource "aws_subnet" "private_subnet-2" {
  vpc_id     = aws_vpc.vpc_ec2.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone = "us-east-1b"
  tags = {
    Name = "private_subnet-2"
  }
}

#create AWS Internet Gateway
resource "aws_internet_gateway" "ec2-igw" {
  vpc_id = aws_vpc.vpc_ec2.id
  tags = {
    Name = "ec2-igw"
  }
}

#create AWS Route Table for the vpc
resource "aws_route_table" "ec2-public-rt" {    
  vpc_id = aws_vpc.vpc_ec2.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ec2-igw.id
  }
  tags = {
    Name = "ec2-public-rt"
  }
}
 #Associate the route table with the public subnets
resource "aws_route_table_association" "public_subnet-1-association" {
  subnet_id      = aws_subnet.public_subnet-1.id
  route_table_id = aws_route_table.ec2-public-rt.id
}
resource "aws_route_table_association" "public_subnet-2-association" {
  subnet_id      = aws_subnet.public_subnet-2.id
  route_table_id = aws_route_table.ec2-public-rt.id
}

 