locals {
  project_name = "3-tire"
}

# Define the subnet configurations
locals {
  public_subnets = {
    public_subnet_1 = {
      cidr_block        = "10.0.0.0/24"
      availability_zone = "ap-south-1a"
    }
    public_subnet_2 = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = "ap-south-1b"
    }

  }
}

locals {
  private_subnets = {
    private_subnet_1 = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = "ap-south-1a"
    }
    private_subnet_2 = {
      cidr_block        = "10.0.3.0/24"
      availability_zone = "ap-south-1b"
    }
    private_subnet_3 = {
      cidr_block        = "10.0.4.0/24"
      availability_zone = "ap-south-1a"
    }
    private_subnet_4 = {
      cidr_block        = "10.0.5.0/24"
      availability_zone = "ap-south-1b"
    }
  }
}



resource "aws_vpc" "vpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${local.project_name}_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${local.project_name}_IGW"
  }
}



# Create subnets using for_each
resource "aws_subnet" "public_subnets" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}


resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    "Name" = "${local.project_name}_public_route_table"
  }
}

resource "aws_route_table_association" "public_route_table_association" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_subnet" "private_subnets" {
  for_each = local.private_subnets

  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = each.key
  }
}


