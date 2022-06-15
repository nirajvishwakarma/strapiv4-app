######### SUMMARY START #############

############# DEV VPC ###############
#  1-VPC1 (Dev)
#  2-Private Subnet 1
#  3-Private Subnet 2
#  4-Public Subnet 1
#  5-Public Subnet 2
#  6-Internet gateway
#  7-Create Elastic IP for Nat
#  8-Create Nat gateway
#  9-Public Route Table
#  10-Public Route Table Association
#  11-Private Route Table
#  12-Route Table association for Both Private VPC
#  
############## PROD VPC ###############
#  13-VPC2 (Prod)
#  14-Private Subnet 3
#  15-Private Subnet 4
#  16-Public Subnet 3
#  17-Public Subnet 4
#  18-Internet gateway
#  19-Create Elastic IP for Nat
#  20-Create Nat gateway
#  21-Public Route Table
#  22-Public Route Table Association
#  23-Private Route Table
#  24-Route Table association for Both Private VPC
#
#
############## JENKINS VPC ###############
#
#  25-Jenkins VPC
#  26-Jenkins Public Subnet
#  27-Jenkins Internet gateway
#  28-Jenkins Route Table
#  29-Jenkins RT Association

########### SUMMARY END ##################

########### DEV VPC ###############
##1.VPC 1
resource "aws_vpc" "WIM-dev" {
  cidr_block = var.cidr-block1
  tags = {
    "Name" = "WIM-${var.env2}",
  }
}

#2.Private Subnet 1
resource "aws_subnet" "private-1" {
  cidr_block        = var.private-1-cidr
  availability_zone = var.private-1-az
  vpc_id            = aws_vpc.WIM-dev.id

  tags = {
    "Name" = "WIM-${var.env2}-private-1"
  }
}

#3.Private Subnet 2
resource "aws_subnet" "private-2" {
  cidr_block        = var.private-2-cidr
  availability_zone = var.private-2-az
  vpc_id            = aws_vpc.WIM-dev.id

  tags = {
    "Name" = "WIM-${var.env2}-private-2"
  }
}

#4.Public Subnet 
resource "aws_subnet" "public" {
  cidr_block        = var.public-cidr
  availability_zone = var.public-az
  vpc_id            = aws_vpc.WIM-dev.id
  map_public_ip_on_launch = true

  tags = {
    "Name" = "WIM-${var.env2}-public"
  }
}


#5.Public Subnet 2
resource "aws_subnet" "public2" {
  cidr_block        = var.public-cidr2
  availability_zone = var.public2-az
  vpc_id            = aws_vpc.WIM-dev.id
  map_public_ip_on_launch = true

  tags = {
    "Name" = "WIM-${var.env2}-public"
  }
}

##6.Internet gateway
resource "aws_internet_gateway" "ig1" {
  vpc_id = aws_vpc.WIM-dev.id
  tags = {
    "Name" = "WIM-${var.env2}"
  }
}

###7.Create Elastic IP for Nat
resource "aws_eip" "eip" {
  depends_on = [aws_internet_gateway.ig1]
  tags = {
    Name = "WIM-${var.env2}-EIP"
  }
}

###8.Create Nat gateway
resource "aws_nat_gateway" "Nat-GW" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public.id
  tags = {
    Name = "WIM-${var.env2}"
  }
  depends_on = [aws_eip.eip]
}

###9.Public Route Table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.WIM-dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig1.id
  }
  tags = {
    "Name" = "WIM-${var.env2}-public"
  }
}

####10.Public Route Table Association
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

###11.Public Route Table Association
resource "aws_route_table_association" "public2" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id
}


###12.Private Route Table
resource "aws_route_table" "private-nat" {
  vpc_id = aws_vpc.WIM-dev.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.Nat-GW.id
  }
  tags = {
    "Name" = "WIM-${var.env2}-public"
  }
}

###Route Table association for Both Private VPC
resource "aws_route_table_association" "private-1" {
  subnet_id      = aws_subnet.private-1.id
  route_table_id = aws_route_table.private-nat.id
}
resource "aws_route_table_association" "private-2" {
  subnet_id      = aws_subnet.private-2.id
  route_table_id = aws_route_table.private-nat.id
}



############# PROD VPC ###############
#VPC 1
resource "aws_vpc" "WIM-prod" {
  cidr_block = var.cidr-block3
  tags = {
    "Name" = "WIM-${var.env4}",
  }
}

###Private Subnet 3
resource "aws_subnet" "private-3" {
  cidr_block        = var.private-3-cidr
  availability_zone = var.private-3-az
  vpc_id            = aws_vpc.WIM-prod.id

  tags = {
    "Name" = "WIM-${var.env4}-private"
    "Environment" = "${var.env4}"
  }
}

##Private Subnet 4
resource "aws_subnet" "private-4" {
  cidr_block        = var.private-4-cidr
  availability_zone = var.private-4-az
  vpc_id            = aws_vpc.WIM-prod.id

  tags = {
   "Name" = "WIM-${var.env4}-private"
  }
}

##Public Subnet 3
resource "aws_subnet" "public-3" {
  cidr_block        = var.public-3-cidr
  availability_zone = var.public-3-az
  vpc_id            = aws_vpc.WIM-prod.id
  map_public_ip_on_launch = true

  tags = {
    "Name" = "WIM-${var.env4}-public"
    "Environment" = "${var.env4}"
  }
}


#Public Subnet 4
resource "aws_subnet" "public-4" {
  cidr_block        = var.public-4-cidr
  availability_zone = var.public-4-az
  vpc_id            = aws_vpc.WIM-prod.id
  map_public_ip_on_launch = true

  tags = {
    "Name" = "WIM-${var.env4}-public"
    "Environment" = "${var.env4}"
  }
}

##Internet gateway
resource "aws_internet_gateway" "ig-2" {
  vpc_id = aws_vpc.WIM-prod.id
  tags = {
    "Name" = "WIM-${var.env4}"
    "Environment" = "${var.env4}"
  }
}

##Create Elastic IP for Nat
resource "aws_eip" "eip-2" {
  depends_on = [aws_internet_gateway.ig-2]
  tags = {
    "Name" = "WIM-${var.env4}-EIP"
  }
}

##Create Nat gateway
resource "aws_nat_gateway" "Nat-GW-2" {
  allocation_id = aws_eip.eip-2.id
  subnet_id     = aws_subnet.public-3.id
  tags = {
    "Name" = "WIM-${var.env4}"
  }
 depends_on = [aws_eip.eip-2]
}

##Public Route Table
resource "aws_route_table" "public-2" {
  vpc_id = aws_vpc.WIM-prod.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig-2.id
  }
  tags = {
    "Name" = "WIM-${var.env4}-public"
  }
}

##Public Route Table Association
resource "aws_route_table_association" "public-3" {
  subnet_id      = aws_subnet.public-3.id
  route_table_id = aws_route_table.public-2.id
}

#Public Route Table Association
resource "aws_route_table_association" "public-4" {
  subnet_id      = aws_subnet.public-4.id
  route_table_id = aws_route_table.public-2.id
}


##Private Route Table
resource "aws_route_table" "private-nat-2" {
  vpc_id = aws_vpc.WIM-prod.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.Nat-GW-2.id
  }
  tags = {
    "Name" = "WIM-${var.env4}-private"
  }
}

##Route Table association for Both Private VPC
resource "aws_route_table_association" "private-3" {
  subnet_id      = aws_subnet.private-3.id
  route_table_id = aws_route_table.private-nat-2.id
}
resource "aws_route_table_association" "private-4" {
  subnet_id      = aws_subnet.private-4.id
  route_table_id = aws_route_table.private-nat-2.id
}



############## JENKINS VPC ################

##Jenkins VPC
resource "aws_vpc" "jenkins" {
  cidr_block = var.cidr-block2
  tags = {
    "Name" = "WIM-Jenkins"
  }
}

#Jenkins Public Subnet
resource "aws_subnet" "jenkins-public" {
  cidr_block        = var.jenkins-public
  availability_zone = var.jenkins-public-az
  vpc_id                  = aws_vpc.jenkins.id
  map_public_ip_on_launch = true

  tags = {
    "Name" = "WIM-Jenkins"
  }
}

##Jenkins Internet gateway
resource "aws_internet_gateway" "ig2" {
  vpc_id = aws_vpc.jenkins.id
  tags = {
    "Name" = "WIM-Jenkins"
  }
}

##Jenkins Route Table
resource "aws_route_table" "jenkins-public" {
  vpc_id = aws_vpc.jenkins.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ig2.id
  }
  tags = {
    "Name" = "WIM-Jenkins"
  }
}

###Jenkins RT Association
resource "aws_route_table_association" "jenkins-rt" {
  subnet_id      = aws_subnet.jenkins-public.id
  route_table_id = aws_route_table.jenkins-public.id
}



