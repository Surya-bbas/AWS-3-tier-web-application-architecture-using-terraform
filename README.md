# AWS-3-tier-web-application-architecture-using-terraform


# Architecture
![image](https://github.com/Surya-bbas/AWS-3-tier-web-application-architecture-using-terraform/assets/99864714/6878fcc1-6306-4009-9cc9-2b4b40afb2b4)

### Components
User Requests:

* Users initiate requests that are routed through Amazon Route 53, a scalable DNS web service.

* Route 53 ensures low-latency routing to endpoints globally.
  
Web Servers:

* The application runs on EC2 instances within an Auto Scaling group across multiple Availability Zones (AZs).
* Auto Scaling dynamically adjusts capacity based on demand.
  
Load Balancing:

* An Application Load Balancer (ALB) efficiently distributes incoming traffic across EC2 instances.
* ALB enhances application availability.

Security and Traffic Routing:

* The architecture uses a VPC with public and private subnets.
* NAT gateways allow outbound traffic from private subnets while blocking unsolicited inbound traffic.
  
Database Tier:

* Amazon RDS provides database services.
* Master-slave replication ensures high availability and failover support.
  

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.47.0 |


## Resources

| Name | Type |
|------|------|
| [aws_eip.eip-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip.epi-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_nat_gateway.public_nat-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_nat_gateway.public_nat-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route_table.private_routeTable-az-1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.private_routeTable-az-2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public_route_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private_subnet-1and3_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.private_subnet-2and4_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public_route_table_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.alb-igw-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.database-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ssh-server-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.web_server-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |


