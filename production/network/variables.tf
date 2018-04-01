variable "aws_region" {}
variable "vpc_cidr" {
	default = "192.168.0.0/16"
}

variable "public_1a_cidr" {
	default = "192.168.1.0/27"
}

variable "public_1b_cidr" {
	default = "192.168.1.33/27"
}
variable "public_1c_cidr" {
        default = "192.168.1.64/27"
}
variable "public_1d_cidr" {
        default = "192.168.1.96/27"
}

variable "private_1a_cidr" {
	default = "192.168.2.0/24"
}

variable "private_1b_cidr" {
	default = "192.168.3.33/24"
}
variable "private_1c_cidr" {
	default = "192.168.4.64/24"
}
variable "private_1d_cidr" {
	default = "192.168.5.0/24"
}
variable "stack"{
    default = "sandbox"
}
variable "sys"{
   default = "SysAdmin"
}
