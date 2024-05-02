resource "aws_security_group" "alb-igw-sg" {
  name   = "ALB Security Group"
  vpc_id = aws_vpc.vpc.id

  description = "igw to alb allow traffic from port 80/443"
  dynamic "ingress" {
    for_each = [{
      port = 80
      },
      {
        port = 443
    }]
    content {
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    "Name" = "${local.project_name}_ALB Security Group"
  }
}

resource "aws_security_group" "ssh-server-sg" {
  name   = "bastin-server Security Group"
  vpc_id = aws_vpc.vpc.id

  description = "allow ssh connection"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.bastin_ip}"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    "Name" = "${local.project_name}_ssh-server Security Group"
  }
}

resource "aws_security_group" "web_server-sg" {

  vpc_id      = aws_vpc.vpc.id
  name        = "Web Server Security Group"
  description = "Enable HTTP/HTTPS access on Port 80/443 via ALB and SSH access on Port 22 via SSH SG"
  dynamic "ingress" {
    for_each = [{
      port            = 80
      sg = aws_security_group.alb-igw-sg.id
      },
      {
        port            = 443
        sg = aws_security_group.alb-igw-sg.id
        }, {
        port            = 22
        sg = aws_security_group.ssh-server-sg.id
    }]
    content {
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      protocol        = "tcp"
      security_groups = ["${ingress.value.sg}"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    "Name" = "${local.project_name}_ALB Security Group"
  }
}

resource "aws_security_group" "database-sg" {
  name   = "database Security Group"
  vpc_id = aws_vpc.vpc.id

  description = "allow mysql connection"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = ["${aws_security_group.web_server-sg.id}"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }



  tags = {
    "Name" = "${local.project_name}_database Security Group"
  }
}


