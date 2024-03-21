resource "aws_instance" "ubuntu" {
  ami = "ami-00c71bd4d220aa22a"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.zone_a_subnets_priv.id
  vpc_security_group_ids = [ aws_security_group.sg_web.id ]

  tags = {
    Name = "Ubuntu"
  }
  user_data = file("userdata.tpl")
}


resource "aws_instance" "bastion" {
  ami = "ami-00c71bd4d220aa22a"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.zone_a_subnets_pub.id
  vpc_security_group_ids = [ aws_security_group.bastion_sg.id ]
  key_name      = "aws_bastion_ssh_key"

  tags = {
    Name = "Bastion"
  }
}
