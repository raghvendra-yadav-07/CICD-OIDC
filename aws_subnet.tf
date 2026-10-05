resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.practice_ssm.id
    cidr_block =  "10.0.1.0/20"
    tags = {
      name = "aws-ssm"

    }
}

resource "aws_internet_gateway" "internet_subnet" {
    vpc_id = aws_vpc.practice_ssm.id

    tags = {
        name = "ig-public"
    }  
}

resource "aws_route_table" "public_route" {
    vpc_id = aws_vpc.practice_ssm.id
    tags = {
      name = "route-for-ssm"
    }
  
  }

resource "aws_route" "config" {
    gateway_id = aws_internet_gateway.internet_subnet.id
    route_table_id = aws_route_table.public_route.id
  
}

resource "aws_route_table_association" "subnet_ig" {
    subnet_id = aws_subnet.public_subnet.id
    route_table_id = aws_route_table.public_route.id
  
}

resource "aws_security_group" "public_sg"{
    vpc_id = aws_vpc.practice_ssm.id
    tags = {
        name ="ssm-internet"
    }
ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = "0.0.0.0/0"
}  
egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = "0.0.0.0/0"
}  
}