# Create VPC
resource "aws_vpc" "AWS-elb-vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "AWS-elb-vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.AWS-elb-vpc.id

  tags = {
    Name = "AWS-elb-igw"
  }
}

# Public Subnet 1
resource "aws_subnet" "elb-public-subnet1" {
  vpc_id                  = aws_vpc.AWS-elb-vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "elb-public-subnet1"
  }
}

# Public Subnet 2
resource "aws_subnet" "elb-public-subnet2" {
  vpc_id                  = aws_vpc.AWS-elb-vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "elb-public-subnet2"
  }
}

# Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.AWS-elb-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

# Associate Route Table with Public Subnet 1
resource "aws_route_table_association" "public1" {
  subnet_id      = aws_subnet.elb-public-subnet1.id
  route_table_id = aws_route_table.public.id
}

# Associate Route Table with Public Subnet 2
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.elb-public-subnet2.id
  route_table_id = aws_route_table.public.id
}