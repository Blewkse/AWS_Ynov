resource "aws_launch_template" "ecs_lt" {
 name_prefix   = "ecs-template"
 image_id      = "ami-00c71bd4d220aa22a"
 instance_type = "t2.micro"

 key_name = "ec2ecsglog"
 vpc_security_group_ids = [aws_security_group.sg_web.id]

 block_device_mappings {
   device_name = "/dev/xvda"
   ebs {
     volume_size = 30
     volume_type = "gp2"
   }
 }

 tag_specifications {
   resource_type = "instance"
   tags = {
     Name = "ecs-instance"
   }
 }

 user_data = filebase64("${path.module}/ecs.sh")
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
