variable "public_subnet_cidrs" {
  type = list(string)
  description = "Public Subnet CIDR values"
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
  
}
variable "private_subnet_cidrs" {
  type = list(string)
  description = "Private Subnet CIDR values"
  default = [ "10.0.3.0/24", "10.0.4.0/24" ]
  
}
variable "availability_zones_ap_south" {
  type = list(string)
  description = "Availability Zones"
  default = [ "ap-south-1a", "ap-south-1b" ]
}
resource "aws_vpc" "s1_vpc_00" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC s1_vpc_00"
  }
}
resource "aws_subnet" "s1_vpc_public_subnets" {
  count = length(var.public_subnet_cidrs)
  vpc_id = aws_vpc.s1_vpc_00.id
  cidr_block = element(var.public_subnet_cidrs, count.index)

  tags = {
    Name = "Public Subnet ${count.index + 1}"
  }
  
}

resource "aws_subnet" "s1_vpc_private_subnets" {
  count = length(var.private_subnet_cidrs)
  vpc_id = aws_vpc.s1_vpc_00.id
  cidr_block = element(var.private_subnet_cidrs, count.index)

  tags = {
    Name = "Private Subnet ${count.index + 1}"
  }
  
}

resource "aws_internet_gateway" "s1_vpc_gw" {
  vpc_id = aws_vpc.s1_vpc_00.id
  tags = {
    Name = "VPC Internet GW"
  }
}

