resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
}

resource "aws_eip" "nat1" {
  domain = "vpc"
}

resource "aws_eip" "nat2" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_public_1" {
    allocation_id = aws_eip.nat1.id
    subnet_id = aws_subnet.zone_a_subnets_pub.id

    depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat_public_2" {
    allocation_id = aws_eip.nat2.id
    subnet_id = aws_subnet.zone_b_subnets_pub.id

    depends_on = [aws_internet_gateway.igw]
}



