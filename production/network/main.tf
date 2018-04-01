
/*
Creating VPC
*/

resource "aws_vpc" "vpc_epic" {
  cidr_block = "${var.vpc_cidr}"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "Flex-VPC"
	Application = "vpc"
	Owner = "${var.sys}"
	Stack = "${var.stack}"
  }
}

/*
Creating Public Subnets
*/

resource "aws_subnet" "public_subnet_us_east_1a" {
  vpc_id                  = "${aws_vpc.vpc_epic.id}"
  cidr_block              = "${var.public_1a_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "Subnet az 1a"
	Tier = "Public"
	Application = "vpc"
	Owner = "${var.sys}"
	Stack = "${var.stack}"
  }
}

resource "aws_subnet" "public_subnet_us_east_1b" {
  vpc_id                  = "${aws_vpc.vpc_epic.id}"
  cidr_block              = "${var.public_1b_cidr}"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"
  tags = {
  	Name =  "Subnet az 1b"
	Tier = "Public"
	Application = "vpc"
	Owner = "${var.sys}"
	Stack = "${var.stack}"
  }
}
resource "aws_subnet" "public_subnet_us_east_1c" {
   vpc_id                  = "${aws_vpc.vpc_epic.id}"
   cidr_block              = "${var.public_1c_cidr}"
   map_public_ip_on_launch = true
   availability_zone = "us-east-1c"
   tags = {
	Name =  "Subnet az 1c"
	Tier = "Public"
	Application = "vpc"
	Owner = "${var.sys}"
	Stack = "${var.stack}"
 }
}

resource "aws_subnet" "public_subnet_us_east_1d" {
   vpc_id                  = "${aws_vpc.vpc_epic.id}"
   cidr_block              = "${var.public_1d_cidr}"
   map_public_ip_on_launch = true
   availability_zone = "us-east-1d"
   tags = {
	Name =  "Subnet az 1d"
        Tier = "Public"
	Application = "vpc"
	Owner = "${var.sys}"
	Stack = "${var.stack}"
 }
}

/*
Create Private Subnet 
*/
resource "aws_subnet" "private_1_subnet_us_east_1a" {
  vpc_id                  = "${aws_vpc.vpc_epic.id}"
  cidr_block              = "${var.private_1a_cidr}"
  availability_zone = "us-east-1a"
  tags = {
  	Name =  "Subnet private 1 az 1a"
	Tier = "Private"
	Application = "vpc"
	Owner = "${var.sys}"
	Stack = "${var.stack}"
  }
}
resource "aws_subnet" "private_1_subnet_us_east_1b" {
  vpc_id                  = "${aws_vpc.vpc_epic.id}"
  cidr_block              = "${var.private_1b_cidr}"
  availability_zone = "us-east-1b"
  tags = {
  	Name =  "Subnet private 1 az 1b"
	Tier = "Private"
	Application = "vpc"
	Owner = "${var.sys}"
	Stack = "${var.stack}"
  }
}
resource "aws_subnet" "private_1_subnet_us_east_1c" {
  vpc_id                  = "${aws_vpc.vpc_epic.id}"
  cidr_block              = "${var.private_1c_cidr}"
  availability_zone = "us-east-1c"
  tags = {
  	Name =  "Subnet private 1 az 1c"
	Tier = "Private"
	Application = "vpc"
	Owner = "${var.sys}"
	Stack = "${var.stack}"
  }
}
resource "aws_subnet" "private_1_subnet_us_east_1d" {
  vpc_id                  = "${aws_vpc.vpc_epic.id}"
  cidr_block              = "${var.private_1d_cidr}"
  availability_zone = "us-east-1d"
  tags = {
  	Name =  "Subnet private 1 az 1d"
	Tier = "Private"
	Application = "vpc"
	Owner = "${var.sys}"
	Stack = "${var.stack}"
  }
}

/*
Create Internet Gateway 
*/

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc_epic.id}"
  tags {
        Name = "InternetGateway"
    	Application = "vpc"
        Owner = "${var.sys}"
	Stack = "${var.stack}"
    }
} 

/*
Create Route to Internet
*/

resource "aws_route" "internet_access" {
  route_table_id         = "${aws_vpc.vpc_epic.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

/*
Creating Elastic IP
*/

resource "aws_eip" "epic_eip" {
  vpc      = true
  depends_on = ["aws_internet_gateway.gw"]
}

/* Create NAT Gateway 
*/

resource "aws_nat_gateway" "nat" {
    allocation_id = "${aws_eip.epic_eip.id}"
    subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"
    depends_on = ["aws_internet_gateway.gw"]
}

/*
Creating Private Route Table 
*/

resource "aws_route_table" "private_route_table" {
    vpc_id = "${aws_vpc.vpc_epic.id}"
 
    tags {
        Name = "Private route table"
	   Application = "vpc"
	   Owner = "${var.sys}"
	   Stack = "${var.stack}"
    }
}
 
resource "aws_route" "private_route" {
	route_table_id  = "${aws_route_table.private_route_table.id}"
	destination_cidr_block = "0.0.0.0/0"
	nat_gateway_id = "${aws_nat_gateway.nat.id}"
}

/*
Create Route Table Associations 
*/

# Associate subnet public_subnet_us_east_1a to public route table
resource "aws_route_table_association" "public_subnet_us_east_1a_association" {
    subnet_id = "${aws_subnet.public_subnet_us_east_1a.id}"
    route_table_id = "${aws_vpc.vpc_epic.main_route_table_id}"
}
# Associate subnet public_subnet_us_east_1b to public route table
resource "aws_route_table_association" "public_subnet_us_east_1b_association" {
    subnet_id = "${aws_subnet.public_subnet_us_east_1b.id}"
    route_table_id = "${aws_vpc.vpc_epic.main_route_table_id}"
}
# Associate subnet public_subnet_us_east_1c to public route table
resource "aws_route_table_association" "public_subnet_us_east_1c_association" {
    subnet_id = "${aws_subnet.public_subnet_us_east_1c.id}"
    route_table_id = "${aws_vpc.vpc_epic.main_route_table_id}"
}
# Associate subnet public_subnet_us_east_1d to public route table
resource "aws_route_table_association" "public_subnet_us_east_1d_association" {
    subnet_id = "${aws_subnet.public_subnet_us_east_1d.id}"
    route_table_id = "${aws_vpc.vpc_epic.main_route_table_id}"
}

# Associate subnet private_1_subnet_us_east_1a to private route table
resource "aws_route_table_association" "pr_1_subnet_us_east_1a_association" {
    subnet_id = "${aws_subnet.private_1_subnet_us_east_1a.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}
# Associate subnet private_1_subnet_us_east_1b to private route table
resource "aws_route_table_association" "pr_1_subnet_us_east_1b_association" {
    subnet_id = "${aws_subnet.private_1_subnet_us_east_1b.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}
# Associate subnet private_1_subnet_us_east_1c to private route table
resource "aws_route_table_association" "pr_1_subnet_us_east_1c_association" {
    subnet_id = "${aws_subnet.private_1_subnet_us_east_1c.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}
# Associate subnet private_1_subnet_us_east_1d to private route table
resource "aws_route_table_association" "pr_1_subnet_us_east_1d_association" {
    subnet_id = "${aws_subnet.private_1_subnet_us_east_1d.id}"
    route_table_id = "${aws_route_table.private_route_table.id}"
}
