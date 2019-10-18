variable "cidr_block" {
  default     = ""
  description = "Ip Range for VPC"
}

variable "vpc_name" {
  default     = ""
  description = "Specify VPCname"
}

variable "availability_zones" {
  description = "Specify availability zones"
  type        = "list"
}

variable "dm_pub_subnets" {
  type = "list"
}

