variable "aws_region" {
  description = "Region in which AWS Resources to be created"
  type        = string
}

#variable "secret_key" {
#  type        = string
#}
#
#variable "access_key" {
#  type        = string
#}
##### Env #######
variable "env1" {
  type = string
}

variable "env2" {
  type = string
}

variable "env3" {
  type = string
}

variable "env4" {
  type = string
}

variable "env5" {
  type = string
}

variable "eks_version" {
  type = string
}


variable "cidr-block1" {
}
variable "cidr-block2" {
}
variable "cidr-block3" {
}
variable "private-1-cidr" {
}
variable "private-1-az" {
}
variable "private-2-cidr" {  
}
variable "private-2-az" {
}

variable "private-3-cidr" {
}
variable "private-3-az" {
}
variable "private-4-cidr" {  
}
variable "private-4-az" {
}

variable "jenkins-public" {  
}
variable "jenkins-public-az" {
}

#public-nat
variable "public-cidr" {
}
variable "public-cidr2" {
}
variable "public-az" {
}
variable "public2-az" {
}

#public-nat
variable "public-3-cidr" {
}
variable "public-4-cidr" {
}
variable "public-3-az" {
}
variable "public-4-az" {
}


locals {
  port = var.ports
}
variable "ports" {
  type = list(any)
  #default = [22, 80, 443, 3000]
}

variable "ec2_instance_type" {
  description = "EC2 Instance Type"
  type        = string
  #default = "t2.micro"
}

#### KEYS ####
variable "ec2-key-test" {
  type = string
}
variable "ec2-key-dev" {
  type = string
}
variable "ec2-key-demo" {
  type = string
}
variable "ec2-key-prod" {
  type = string
}
variable "ec2-key" {
  type = string
}