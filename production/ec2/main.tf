resource "null_resource" "comment" {

provisioner local-exec {
	command = "echo '#creating host file' > publicips.txt"  
	}
}

data "terraform_remote_state" "network" {
  backend = "s3"
  config {
    bucket = "${var.vpc_bucket}"
    key = "network/test"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "sg" {
  backend = "s3"
  config {
    bucket = "${var.sg_bucket}"
    key = "security_groups/key"
    region = "us-east-1"
  }
}



resource "aws_instance" "appserver-1a" {
    ami = "${var.appserver_inst["ami_id"]}"
    count = "${var.appserver_inst["count"]}"
    availability_zone = "${var.az_1a}"
    instance_type = "${var.appserver_inst["instance_type"]}"
    key_name = "${var.key_name}"
    vpc_security_group_ids = ["${data.terraform_remote_state.sg.epic-appserver}"]
    subnet_id = "${data.terraform_remote_state.network.private_subnet_id_east_1a}"
    associate_public_ip_address = true
    source_dest_check = false


    tags {
        Name = "appserver-1a-${(count.index)}"
	application = "app:frontend" 
	stack = "${var.stack}" 
	owner = "${var.owner}"
        }
}

/*

resource "aws_eip" "appeip-1a" {
    count = "${var.appserver_inst["count"]}"
    instance = "${element(aws_instance.appserver-1a.*.id, count.index)}"
    vpc = true  

}

*/


resource "aws_instance" "appserver-1b" {

    ami = "${var.appserver_inst["ami_id"]}"
    count = "${var.appserver_inst["count"]}"
    availability_zone = "${var.az_1b}"
    instance_type = "${var.appserver_inst["instance_type"]}"
    key_name = "${var.key_name}"
    vpc_security_group_ids = ["${data.terraform_remote_state.sg.epic-appserver}"]
    subnet_id = "${data.terraform_remote_state.network.private_subnet_id_east_1b}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "appserver-1b-${(count.index)}"
	application = "app:frontend" 
	stack = "${var.stack}"
	owner = "{var.owner}"
        }
}

/*
resource "aws_eip" "appeip-1b" {
    count = "${var.appserver_inst["count"]}"
    instance = "${element(aws_instance.appserver-1b.*.id, count.index)}"
    vpc = true

}

*/


resource "aws_instance" "activemq-1a" {
    ami = "${var.amq_inst["ami_id"]}"
    count = "${var.amq_inst["count"]}"
    availability_zone =  "${var.az_1a}"
    instance_type = "${var.amq_inst["instance_type"]}"
    key_name = "${var.key_name}"
    vpc_security_group_ids = ["${data.terraform_remote_state.sg.epic-activemq-sg}"]
    subnet_id = "${data.terraform_remote_state.network.private_subnet_id_east_1a}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
           Name = "activemq-1a-${(count.index)}"
	   application = "app:activemq"
	   stack = "${var.stack}"
	   owner = "{var.owner}"
    }
}
/*


resource "aws_eip" "amqeip-1a" {
    count = "${var.amq_inst["count"]}"
    instance = "${element(aws_instance.activemq-1a.*.id, count.index)}"
    vpc = true 

}

*/


resource "aws_instance" "activemq-1b" {
    ami = "${var.amq_inst["ami_id"]}"
    count = "${var.amq_inst["count"]}"
    availability_zone =  "${var.az_1b}"
    instance_type = "${var.amq_inst["instance_type"]}"
    key_name = "${var.key_name}"
    vpc_security_group_ids = ["${data.terraform_remote_state.sg.epic-activemq-sg}"]
    subnet_id = "${data.terraform_remote_state.network.private_subnet_id_east_1b}"
    associate_public_ip_address = true
    source_dest_check = false


    tags {
          Name = "activemq-1b-${(count.index)}"
	  application = "app:activemq"
          stack = "${var.stack}"
          owner = "{var.owner}"

    }
}


/*
resource "aws_eip" "amqeip-1b" {
    count = "${var.amq_inst["count"]}"
    instance = "${element(aws_instance.activemq-1b.*.id, count.index)}"    
    vpc = true
}


*/
resource "aws_instance" "backend-appserver-1a" {

    ami = "${var.appserver_inst["ami_id"]}"
    count = "${var.appserver_inst["count"]}"
    availability_zone =  "${var.az_1a}"
    instance_type = "${var.appserver_inst["instance_type"]}"
    key_name = "${var.key_name}"
    vpc_security_group_ids = ["${data.terraform_remote_state.sg.epic-appserver}"]
    subnet_id = "${data.terraform_remote_state.network.private_subnet_id_east_1a}"
    associate_public_ip_address = true
    source_dest_check = false


    tags {
        Name = "backend-appserver-1a-${(count.index)}"
        application = "app:backend"
        stack = "${var.stack}"
        owner = "{var.owner}"

    }

}

/*

resource "aws_eip" "backend-appeip-1a" {
    count = "${var.appserver_inst["count"]}"
    instance = "${element(aws_instance.backend-appserver-1a.*.id, count.index)}"
    vpc = true


}


*/
    resource "aws_instance" "backend-appserver-1b" {
    ami = "${var.appserver_inst["ami_id"]}"
    count = "${var.appserver_inst["count"]}"
    availability_zone =  "${var.az_1b}"
    instance_type = "${var.appserver_inst["instance_type"]}"
    key_name = "${var.key_name}"
    vpc_security_group_ids = ["${data.terraform_remote_state.sg.epic-appserver}"]
    subnet_id = "${data.terraform_remote_state.network.private_subnet_id_east_1b}"
    associate_public_ip_address = true
    source_dest_check = false
    tags {
        Name = "backend-appserver-1b-${(count.index)}"
        application = "app:backend"
        stack = "${var.stack}"
        owner = "{var.owner}"

        }
}

/*
resource "aws_eip" "backend-appeip-1b" {
    count = "${var.appserver_inst["count"]}" 
    instance = "${element(aws_instance.backend-appserver-1b.*.id, count.index)}"
    vpc = true
	
}

*/



resource "null_resource" "appserver-1a" {
 count = "${var.appserver_inst["count"]}"
  triggers = {
        inst_ids = "${element(aws_instance.appserver-1a.*.id, count.index)}"
	}
    provisioner "local-exec" {
    command = "echo '[appserver-1a-${(count.index)}]' >> publicips.txt ; echo '${element(aws_instance.appserver-1a.*.public_ip, count.index)}' >> publicips.txt "
   	}

}


resource "null_resource" "appserver-1b" {
 count = "${var.appserver_inst["count"]}"
  triggers = {
        inst_ids = "${element(aws_instance.appserver-1b.*.id, count.index)}"
}
    provisioner "local-exec" {
    command = "echo '[appserver-1b-${(count.index)}]' >> publicips.txt ; echo '${element(aws_instance.appserver-1b.*.public_ip, count.index)}' >> publicips.txt "
   }

}

resource "null_resource" "activemq-1a" {
 count = "${var.amq_inst["count"]}"
  triggers = {
        inst_ids = "${element(aws_instance.activemq-1a.*.id, count.index)}"
}
    provisioner "local-exec" {
    command = "echo '[activemq-1a-${(count.index)}]' >> publicips.txt ; echo '${element(aws_instance.activemq-1a.*.public_ip, count.index)}' >> publicips.txt "
   }

}

resource "null_resource" "activemq-1b" {
 count = "${var.amq_inst["count"]}"
  triggers = {
        inst_ids = "${element(aws_instance.activemq-1b.*.id, count.index)}"
}
    provisioner "local-exec" {
    command = "echo '[activemq-1b-${(count.index)}]' >> publicips.txt ; echo '${element(aws_instance.activemq-1b.*.public_ip, count.index)}' >> publicips.txt "
   }

}


resource "null_resource" "backend-appserver-1a" {
 count = "${var.appserver_inst["count"]}"
  triggers = {
        inst_ids = "${element(aws_instance.backend-appserver-1a.*.id, count.index)}"
}
    provisioner "local-exec" {
    command = "echo '[backend-appserver-1a-${(count.index)}]' >> publicips.txt ; echo '${element(aws_instance.backend-appserver-1a.*.public_ip, count.index)}' >> publicips.txt "
   }

}

resource "null_resource" "backend-appserver-1b" {
 count = "${var.appserver_inst["count"]}"
  triggers = {
        inst_ids = "${element(aws_instance.backend-appserver-1b.*.id, count.index)}"
}
    provisioner "local-exec" {
    command = "echo '[backend-appserver-1b-${(count.index)}]' >> publicips.txt ; echo '${element(aws_instance.backend-appserver-1b.*.public_ip, count.index)}' >> publicips.txt "
   }

}
