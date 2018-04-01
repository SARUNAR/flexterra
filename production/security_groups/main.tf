#Security Groups
#Edited
data "terraform_remote_state" "network" {
  backend = "s3"
  config {
    bucket = "XXXXXXX"
    key = "network/test"    
    region = "us-east-1"
  }
}

resource "aws_security_group" "epic-alb" {
  name        = "epic-alb"
  description = "Allow all inbound traffic"
  vpc_id = "${data.terraform_remote_state.network.epic_vpc_id}"
  
  ingress {
    from_port   = 0
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 0
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 0
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 0
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_all"
	Application = "sec_group"
	Stack = "${var.stack}"
	Owner = "SysAdmin"
  }
}
 
# creating ActiveMQ-SG

resource "aws_security_group" "epic-amq" {
    name = "vpc_amq"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 0
        to_port = 61616
        protocol = "tcp"
        security_groups = ["${aws_security_group.epic-appserver.id}"]
    }
    ingress {
        from_port = 0
        to_port = 8161
        protocol = "tcp"
        security_groups = ["${aws_security_group.epic-monitor.id}","${aws_security_group.epic-sysadmin-sg.id}"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        security_groups = ["${aws_security_group.epic-alb.id}"]
    }

    vpc_id = "${data.terraform_remote_state.network.epic_vpc_id}"

    tags {
        Name = "activeMQ-sg"
		Application = "sec_group"
		Stack = "${var.stack}"
		Owner = "SysAdmin"
    }
}

# Creating AppServer-SG

resource "aws_security_group" "epic-appserver" {
    name = "vpc_appserver"
    description = "Allow incoming HTTP connections."

    ingress {
        from_port = 0
        to_port = 80
        protocol = "tcp"
        security_groups = ["${aws_security_group.epic-alb.id}"]
    }

    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        security_groups = ["${aws_security_group.epic-alb.id}"]
    }

    vpc_id = "${data.terraform_remote_state.network.epic_vpc_id}"

    tags {
        Name = "appServer-sg"
		Application = "sec_group"
		Stack = "${var.stack}"
		Owner = "SysAdmin"
    }
}

# Creating ReceiptDB-SG

resource "aws_security_group" "epic-receiptdb" {
    name = "vpc_receiptdb"
    description = "Allow incoming HTTP connections from appServer-sg."

    ingress {
        from_port = 0
        to_port = 3306
        protocol = "tcp"
        security_groups = ["${aws_security_group.epic-appserver.id}","${aws_security_group.epic-monitor.id}"]
    }
    
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        security_groups = ["${aws_security_group.epic-appserver.id}"]
    }

    vpc_id = "${data.terraform_remote_state.network.epic_vpc_id}"

    tags {
        Name ="ReceiptDB-SG"
			Application = "sec_group"
			Stack = "${var.stack}"
			Owner = "SysAdmin"
    }
}

#Creating epic-sysadmin	

resource "aws_security_group" "epic-sysadmin-sg" {
  name        = "epic-sysadmin"
  description = "epic-sysadmin security group"
  vpc_id = "${data.terraform_remote_state.network.epic_vpc_id}"

  ingress {
    from_port   = 0
    to_port     = 22
    protocol    = "tcp"
   # security_groups = ["${aws_security_group.epic-amq.id}","${aws_security_group.epic-appserver.id}"]
  }
  
   tags {
    Name = "epic-sysadmin-sg"
      Application = "sec_group"
      Stack = "${var.stack}"
      Owner = "SysAdmin"
  }
}

#Security Group for Monitoring apps	

resource "aws_security_group" "epic-monitor" {
  name        = "epic-monitor"
  description = "epic-monitor security group "
  vpc_id = "${data.terraform_remote_state.network.epic_vpc_id}"

 ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
 # security_groups = ["${aws_security_group.epic-alb.id}","${aws_security_group.epic-receiptdb.id}","${aws_security_group.epic-appserver.id}"]
  }

 tags {
    Name = "monitor-sg"
      Application = "sec_group"
      Stack = "${var.stack}"
      Owner = "SysAdmin"
  }
}
