# Define our VPC
resource "aws_vpc" "default" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_hostnames = true

  tags {
    Name = "test-vpc"
  }
}

# Define the public subnet1
resource "aws_subnet" "public-subnet1" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_cidr1}"
  availability_zone = "us-east-1a"

  tags {
    Name = "Web Public Subnet1"
  }
}

# Define the public subnet2
resource "aws_subnet" "public-subnet2" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.public_subnet_cidr2}"
  availability_zone = "us-east-1b"

  tags {
    Name = "Web Public Subnet2"
  }
}

# Define the private subnet1
resource "aws_subnet" "private-subnet1" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet_cidr1}"
  availability_zone = "us-east-1a"

  tags {
    Name = "Private Subnet1"
  }
}

# Define the private subnet2
resource "aws_subnet" "private-subnet2" {
  vpc_id = "${aws_vpc.default.id}"
  cidr_block = "${var.private_subnet_cidr2}"
  availability_zone = "us-east-1b"

  tags {
    Name = "Private Subnet2"
  }
}




# Define the internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "VPC IGW"
  }
}

# Creating Elastic IPa
resource "aws_eip" "nat" {
       vpc = true
}
# Creating NAT Gatway
resource "aws_nat_gateway" "gw" {
  allocation_id = "${aws_eip.nat.id}"
  subnet_id     = "${aws_subnet.public-subnet1.id}"

  tags = {
    Name = "NAT gw"
  }
}

# Define the route table Public Subnet
resource "aws_route_table" "web-public-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "Public Subnet RT"
  }
}

# Define the route table for Private Subnet
resource "aws_route_table" "web-private-rt" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_nat_gateway.gw.id}"
  }

  tags {
    Name = "Private Subnet RT"
  }
}


# Assign the route table to the private Subnet1
resource "aws_route_table_association" "web-private-rt1" {
  subnet_id = "${aws_subnet.private-subnet1.id}"
  route_table_id = "${aws_route_table.web-private-rt.id}"
}

# Assign the route table to the private Subnet2
resource "aws_route_table_association" "web-private-rt2" {
  subnet_id = "${aws_subnet.private-subnet2.id}"
  route_table_id = "${aws_route_table.web-private-rt.id}"
}





# Assign the route table to the public Subnet1
resource "aws_route_table_association" "web-public-rt1" {
  subnet_id = "${aws_subnet.public-subnet1.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}




# Assign the route table to the public Subnet2
resource "aws_route_table_association" "web-public-rt2" {
  subnet_id = "${aws_subnet.public-subnet2.id}"
  route_table_id = "${aws_route_table.web-public-rt.id}"
}

# Define the security group for
resource "aws_security_group" "sgweb" {
  name = "vpc_test_web"
  description = "Allow incoming HTTP connections & SSH access"
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
vpc_id = "${aws_vpc.default.id}"
 tags = {
    Name = "allow_all"
  }

}
