output "epic-alb-sg" {
  value = "${aws_security_group.epic-alb.id}"
}

output "epic-activemq-sg" {
  value = "${aws_security_group.epic-amq.id}"
}

output "epic-appserver" {
   value = "${aws_security_group.epic-appserver.id}"
}

output "epic-receiptdb-sg" {
   value = "${aws_security_group.epic-receiptdb.id}"
}

output "epic-monitor" {
	value = "${aws_security_group.epic-monitor.id}"
}

output "epic-sysadmin"{
	value = "${aws_security_group.epic-sysadmin-sg.id}"
}
