resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.practice_ssm.id
  cidr_block = "10.0.1.0/20"

  tags = {
    Name = "aws-ssm"
  }
}

resource "aws_internet_gateway" "internet_subnet" {
  vpc_id = aws_vpc.practice_ssm.id

  tags = {
    Name = "ig-public"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.practice_ssm.id

  tags = {
    Name = "route-for-ssm"
  }
}

resource "aws_route" "config" {
  route_table_id         = aws_route_table.public_route.id
  gateway_id             = aws_internet_gateway.internet_subnet.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route_table_association" "subnet_ig" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.practice_ssm.id

  tags = {
    Name = "ssm-internet"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}