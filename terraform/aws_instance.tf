resource "aws_key_pair" "key_pair"{
    key_name = "ssm"
    public_key = file("ssm.pub")
}

  



resource "aws_instance" "ssm_ec2" {
    ami           = "ami-0b6d9d3d33ba97d99"
  instance_type = "t2.micro"

  subnet_id = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.public_sg.id]
  associate_public_ip_address = true
  key_name = aws_key_pair.key_pair.id

  tags ={
    name = "ssm-practice"
  }
}