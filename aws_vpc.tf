resource "aws_vpc" "practice_ssm" {
    cidr_block = "10.0.0.0/16"
    region = "us-east-1"
    tags = {
      name = "ssm-vpc"
    }
  
}