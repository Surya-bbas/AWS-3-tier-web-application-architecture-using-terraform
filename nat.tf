resource "aws_nat_gateway" "public_nat-1" {
  allocation_id = aws_eip.eip-1.id
  subnet_id     = aws_subnet.public_subnets["public_subnet_1"].id


  tags = {
    Name = "${local.project_name}_public_nat-1"
  }


  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "public_nat-2" {
  allocation_id = aws_eip.epi-2.id
  subnet_id     = aws_subnet.public_subnets["public_subnet_2"].id


  tags = {
    Name = "${local.project_name}_public_nat-2"
  }


  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "eip-1" {
  domain   = "vpc"
  tags = {
    "Name" = "${local.project_name}_epi-1"
  }
}

resource "aws_eip" "epi-2" {
  domain   = "vpc"
  tags = {
    "Name" = "${local.project_name}_epi-2"
  }
}

resource "aws_route_table" "private_routeTable-az-1" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat-1.id
  }

  tags = {
    Name = "${local.project_name}_private_routeTable-az-1"
  }
}

resource "aws_route_table" "private_routeTable-az-2" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.public_nat-2.id
  }

  tags = {
    Name = "${local.project_name}_private_routeTable-az-2"
  }
}

resource "aws_route_table_association" "private_subnet-1and3_association" {
  for_each = {
    "private_subnet-1" = aws_subnet.private_subnets["private_subnet_1"].id
    "private_subnet-3" = aws_subnet.private_subnets["private_subnet_3"].id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.private_routeTable-az-1.id
}

resource "aws_route_table_association" "private_subnet-2and4_association" {
  for_each = {
    "private_subnet-2" = aws_subnet.private_subnets["private_subnet_2"].id
    "private_subnet-4" = aws_subnet.private_subnets["private_subnet_4"].id
  }
  subnet_id      = each.value
  route_table_id = aws_route_table.private_routeTable-az-2.id
}