variable "aws_region" {}

variable "key_path" {}

variable "key_name" {}

variable "amq_inst" {
                type = "map"
        default =       {
                ami_id = "ami-4fffc834"
                instance_type = "t2.micro"
                count = "1"
                }
}

variable "appserver_inst" {
 	type = "map"
        default =       {
                ami_id = "ami-4fffc834"
                instance_type = "t2.micro"
                count = "1"
                }
}

variable "stack" {
 	default = "sandbox"

}

variable "sg_bucket" {
	default = "<<your bucket name>>"
}

variable "vpc_bucket" {
	default = "<<your bucket name>>"
}

variable "owner" {
	default = "sysadmin"
 
}
 
variable "az_1a" {
 	default = "us-east-1a"
}

variable "az_1b" {
        default = "us-east-1b"
}

/*
variable "appserver-1a-publicip" {
	default = ["${aws_instance.appserver-1a.*.public_ip}"]
}


variable "appserver-1b-publicip" {
        default = ["${aws_instance.appserver-1b.*.public_ip}"]
}

variable "activemq-1a-publicip" {
        default = ["${aws_instance.activemq-1a.*.public_ip}"]
}

variable "activemq-1b-publicip" {
        default = ["${aws_instance.activemq-1b.*.public_ip}"]
}

variable "backend-appserver-1a-publicip" {
        default = ["${aws_instance.backend-appserver-1a.*.public_ip}"]
}

variable "backend-appserver-1b-publicip" {
        default = "${aws_instance.backend-appserver-1b.*.public_ip}"
}
*/
