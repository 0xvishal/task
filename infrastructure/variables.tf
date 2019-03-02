variable "aws_region" {
  description = "Region for the VPC"
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/26"
}

variable "public_subnet_cidr1" {
  description = "CIDR for the public subnet"
  default = "10.0.0.0/28"
}

variable "public_subnet_cidr2" {
  description = "CIDR for the public subnet"
  default = "10.0.0.16/28"
}


variable "private_subnet_cidr1" {
  description = "CIDR for the private subnet"
  default = "10.0.0.32/28"
}

variable "private_subnet_cidr2" {
  description = "CIDR for the private subnet"
  default = "10.0.0.48/28"
}

variable "ami" {
  description = "AMI for EC2"
   default = "ami-0f9cf087c1f27d9b1"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "/home/ubuntu/id_rsa.pub"
}
