resource "aws_route_table" "public-1" {
    vpc_id=aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public-1" {
  subnet_id = aws_subnet.zone_a_subnets_pub.id
  route_table_id = aws_route_table.public-1.id
}

resource "aws_route_table" "public-2" {
    vpc_id=aws_vpc.main.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public-2" {
  subnet_id = aws_subnet.zone_b_subnets_pub.id
  route_table_id = aws_route_table.public-2.id
}


resource "aws_route_table" "private-1" {
  vpc_id = aws_vpc.main.id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_public_1.id
  }
}
resource "aws_route_table_association" "private-1" {
  subnet_id = aws_subnet.zone_a_subnets_priv.id
  route_table_id = aws_route_table.private-1.id
}

resource "aws_route_table" "private-2" {
  vpc_id = aws_vpc.main.id

  route{
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat_public_2.id
  }
}
resource "aws_route_table_association" "private-2" {
  subnet_id = aws_subnet.zone_b_subnets_priv.id
  route_table_id = aws_route_table.private-2.id
}