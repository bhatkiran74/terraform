#vpc
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(var.tags, { Name = "${var.environment_name}-vpc" })

  lifecycle {
    prevent_destroy = false
  }

}
#Internate gateway

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = merge(var.tags, {
    Name = "${var.environment_name}-igw"
  })
}
#public subnet

resource "aws_subnet" "public" {
  for_each                = { for idx, az in local.azs : az => local.public_subnet_cidrs[idx] }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags                    = merge(var.tags, { Name = "${var.environment_name}-pub-sub-${each.key}" })
}

#private subnet
resource "aws_subnet" "private" {
  for_each                = { for idx, az in local.azs : az => local.private_subnet_cidrs[idx] }
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true
  tags                    = merge(var.tags, { Name = "${var.environment_name}-pri-sub-${each.key}" })
}

#elsastic ip
resource "aws_eip" "nat" {
  tags = merge(var.tags, { Name = "${var.environment_name}-nat-eip" })

}


#nat gateway

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id

  tags = merge(var.tags, { Name = "${var.environment_name}-nat" })


  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}




#public route table
resource "aws_route_table" "public_rt" {

  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = merge(var.tags, { Name = "${var.environment_name}-public-rt" })



}
#public route table association

resource "aws_route_table_association" "public_rt_assoc" {

  for_each = aws_subnet.public


  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}

#private route table

# Resource-9: Private Route Table
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = merge(var.tags, { Name = "${var.environment_name}-private-rt" })
}

# Resource-10: Private Route Table Association to Private Subnet
resource "aws_route_table_association" "private_rt_assoc" {
  for_each = aws_subnet.private
  subnet_id      = each.value.id
  route_table_id = aws_route_table.private_rt.id
}