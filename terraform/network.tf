resource "aws_vpc" "main"{
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "jenkins-project-vpc"
  }
}


resource "aws_internet_gateway" "main"{
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "jenkins-project-igw"
  }
}


resource "aws_subnet" "public"{
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "jenkins-project-public-subnet"
  }
}


resource "aws_subnet" "public2"{
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.4.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "jenkins-project-public-subnet-2"
  }
}



resource "aws_subnet" "private"{
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1b"

  tags={
    Name = "jenkins-project-private-subnet"
  }
}


resource "aws_subnet" "private2"{
  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "ap-south-1c"

  tags = {
    Name = "jenkins-project-private-subnet-2"
  }
}


resource "aws_eip" "nat"{
  domain = "vpc"

  tags = {
    Name = "jenkins-project-nat-eip"
  }
}


resource "aws_nat_gateway" "main"{
  allocation_id = aws_eip.nat.id
  subnet_id = aws_subnet.public.id

  tags = {
    Name = "jenkins-project-nat"
  }

  depends_on = [aws_internet_gateway.main]
}


resource "aws_route_table" "public"{
  vpc_id = aws_vpc.main.id 
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
  
  tags = {
    Name = "jenkins-project-public-rt"
  } 
}


resource "aws_route_table" "private"{
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "jenkins-project-private-rt"
  }
}


resource "aws_route_table_association" "public"{
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}


resource "aws_route_table_association" "private"{
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}


resource "aws_route_table_association" "private2"{
  subnet_id = aws_subnet.private2.id
  route_table_id = aws_route_table.private.id
}


resource "aws_route_table_association" "public2" {
  subnet_id = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}
