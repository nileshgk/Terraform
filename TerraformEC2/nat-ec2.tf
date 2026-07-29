# Define external IP address for NAT Gateway
resource "aws_eip" "nat_eip-ec2" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gw-ec2" {
  allocation_id = aws_eip.nat_eip-ec2.id
  subnet_id     = aws_subnet.public_subnet-1.id
  depends_on = [aws_internet_gateway.ec2-igw]
}

resource "aws_route_table" "ec2-private-rt" {
  vpc_id = aws_vpc.vpc_ec2.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw-ec2.id
  }
  tags = {
    Name = "ec2-private-rt"
  }
}
resource "aws_route_table_association" "private_subnet-1-association" {
  subnet_id      = aws_subnet.private_subnet-1.id
  route_table_id = aws_route_table.ec2-private-rt.id
}
resource "aws_route_table_association" "private_subnet-2-association" {
  subnet_id      = aws_subnet.private_subnet-2.id
  route_table_id = aws_route_table.ec2-private-rt.id
}
