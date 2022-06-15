############ Peering between DEV VPC and Jenkins VPC #############
#
#
#resource "aws_vpc_peering_connection" "primary2secondary" {
#  # Main VPC ID.
#  vpc_id = "${aws_vpc.WIM-Test.id}"
#
#  # AWS Account ID. This can be dynamically queried using the
#  # aws_caller_identity data resource.
#  # https://www.terraform.io/docs/providers/aws/d/caller_identity.html
#  peer_owner_id = 817141239014
#
#  # Secondary VPC ID.
#  peer_vpc_id = "${aws_vpc.jenkins.id}"
#
#  # Flags that the peering connection should be automatically confirmed. This
#  # only works if both VPCs are owned by the same account.
#  auto_accept = true
#
#
#  tags = {
#    Name = "VPC Peering between dev and Jnkins"
#  }
#}
#
###aws_route on VPC 1 main route table
#resource "aws_route" "primary2secondary" {
#  # ID of VPC 1 main route table.
#  route_table_id = "${aws_route_table.public.id}"
#
#  # CIDR block / IP range for VPC 2.
#  destination_cidr_block = var.cidr-block2
#
#  # ID of VPC peering connection.
#  vpc_peering_connection_id = "${aws_vpc_peering_connection.primary2secondary.id}"
#}

##aws_route on VPC 2 main route table.
#resource "aws_route" "secondary2primary" {
#  # ID of VPC 2 main route table.
#  route_table_id = "${aws_route_table.jenkins-public.id}"
#
#  # CIDR block / IP range for VPC 2.
#  destination_cidr_block = var.cidr-block1
#
#  # ID of VPC peering connection.
#  vpc_peering_connection_id = "${aws_vpc_peering_connection.primary2secondary.id}"
#}
#
############ Peering between PROD VPC and Jenkins VPC #############
#
#resource "aws_vpc_peering_connection" "prod-2-jenkins" {
#  # Main VPC ID.
#  vpc_id = "${aws_vpc.WIM-prod.id}"
#
#  # AWS Account ID. This can be dynamically queried using the
#  # aws_caller_identity data resource.
#  # https://www.terraform.io/docs/providers/aws/d/caller_identity.html
#  peer_owner_id = 817141239014
#
#  # Secondary VPC ID.
#  peer_vpc_id = "${aws_vpc.jenkins.id}"
#
#  # Flags that the peering connection should be automatically confirmed. This
#  # only works if both VPCs are owned by the same account.
#  auto_accept = true
#
#  tags = {
#    Name = "VPC Peering between prod and Jnkins"
#  }
#}
#
###aws_route on PROD VPC main route table
#resource "aws_route" "prod-2-jenkins" {
#  # ID of VPC 1 main route table.
#  route_table_id = "${aws_route_table.public-2.id}"
#
#  # CIDR block / IP range for Jenkins VPC.
#  destination_cidr_block = var.cidr-block2
#
#  # ID of VPC peering connection.
#  vpc_peering_connection_id = "${aws_vpc_peering_connection.prod-2-jenkins.id}"
#}
#
##aws_route on Jenkins VPC  main route table.
#resource "aws_route" "jenkins-2-prod" {
#  # ID of VPC 2 main route table.
#  route_table_id = "${aws_route_table.jenkins-public.id}"
#
#  # CIDR block / IP range for PROD VPC.
#  destination_cidr_block = var.cidr-block3
#
#  # ID of VPC peering connection.
#  vpc_peering_connection_id = "${aws_vpc_peering_connection.prod-2-jenkins.id}"
#}
#


