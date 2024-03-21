resource "aws_subnet" "zone_a_subnets_pub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-3a"
  map_public_ip_on_launch = true

  tags = {
    Name = "zone_a_subnets_pub"
    Type = "Public"
  }
}
resource "aws_subnet" "zone_a_subnets_priv" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "eu-west-3a"
  map_public_ip_on_launch = false

  tags = {
    Name = "zone_a_subnets_pri"
    Type = "Private"

  }
}
resource "aws_subnet" "zone_b_subnets_pub" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "eu-west-3b"
  map_public_ip_on_launch = true

  tags = {
    Name = "zone_b_subnets_pub"
    Type = "Public"

  }
}
resource "aws_subnet" "zone_b_subnets_priv" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "eu-west-3b"
  map_public_ip_on_launch = false

  tags = {
    Name = "zone_b_subnets_pri"
    Type = "Private"
  }
}