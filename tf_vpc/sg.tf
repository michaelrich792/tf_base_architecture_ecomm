######################################
# Multiple SGs defined here 
# - ssh 
# - egress
######################################

# Default ssh 22 
resource "aws_security_group" "dm_default_ssh_sg_res" {
  name_prefix = "Bastion Host SG"
  description = "Allow inbound to bastion on vpc ${aws_vpc.dm_vpc_res.id} VPC"
  vpc_id      = "${aws_vpc.dm_vpc_res.id}"

  lifecycle {
    create_before_destroy = "true"
  }
}

resource "aws_security_group_rule" "dm_ssh_ingress_res" {
  type              = "ingress"
  to_port           = "22"
  from_port         = "22"
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dm_default_ssh_sg_res.id}"
}

resource "aws_security_group_rule" "dm_sg_egress_res" {
  type              = "egress"
  to_port           = "0"
  from_port         = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dm_default_ssh_sg_res.id}"
}

# Allow port 8080 (From PUBLIC subnet to PRIVATE)
resource "aws_security_group" "dm_default_8080_sg_res" {
  name_prefix = "Allowed Traffic Public -to- Private SG"
  description = "Allow inbound to PRIVATE ${aws_vpc.dm_vpc_res.id} VPC"
  vpc_id      = "${aws_vpc.dm_vpc_res.id}"

  lifecycle {
    create_before_destroy = "true"
  }
}

resource "aws_security_group_rule" "dm_pri_8080_ingress_res" {
  type              = "ingress"
  to_port           = "8080"
  from_port         = "8080"
  protocol          = "tcp"
  cidr_blocks       = ["10.20.0.0/24", "10.20.1.0/24", "10.20.2.0/24"]
  security_group_id = "${aws_security_group.dm_default_8080_sg_res.id}"
}

#resource "aws_security_group_rule" "dm_pri_ssh_ingress_res" {
#  type              = "ingress"
#  to_port           = "22"
#  from_port         = "22"
#  protocol          = "tcp"
#  cidr_blocks       = ["10.20.0.0/24", "10.20.1.0/24", "10.20.2.0/24"]
#  security_group_id = "${aws_security_group.dm_default_8080_sg_res.id}"
#}

resource "aws_security_group_rule" "dm_pri_sg_egress_res" {
  type              = "egress"
  to_port           = "0"
  from_port         = "0"
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.dm_default_8080_sg_res.id}"
}

