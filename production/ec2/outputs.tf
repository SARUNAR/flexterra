
output "appserver_id_1a" {
        value = ["${aws_instance.appserver-1a.*.id}"]
}
output "appserver_id_1b" {
	value = ["${aws_instance.appserver-1b.*.id}"]
}
output "activemq_id_1a" {
        value = ["${aws_instance.activemq-1a.*.id}"]
}
output "amq_id_1b" {
        value = ["${aws_instance.activemq-1b.*.id}"]
}
output "backendapp_id_1a" {
        value = ["${aws_instance.backend-appserver-1a.*.id}"]
}
output "backendapp_id_1b" {
        value = ["${aws_instance.backend-appserver-1b.*.id}"]
}

output "appserver_public_ips_1a" {
        value = ["${aws_instance.appserver-1a.public_ip}"]
}
output "appserver_public_ips_1b" {
        value = ["${aws_instance.appserver-1b.*.public_ip}"]
}
output "amq_public_ips_1a" {
        value = ["${aws_instance.activemq-1a.*.public_ip}"]
}
output "amq_public_ips_1b" {
        value = ["${aws_instance.activemq-1b.*.public_ip}"]
}
output "backendapp_public_ip_1a" {
        value = ["${aws_instance.backend-appserver-1a.*.public_ip}"]
}
output "backendapp_public_ip_1b" {
        value = ["${aws_instance.backend-appserver-1b.*.public_ip}"]
}
/*

output "appserver_eip_ips_1a" {
        value = ["${aws_eip.appeip-1a.*.public_ip}"]
}

output "appserver_eip_ips_1b" {
        value = ["${aws_eip.appeip-1b.*.public_ip}"]
}

output "amq_eip_ips_1a" {
        value = ["${aws_eip.amqeip-1a.*.public_ip}"]
}

output "amq_eip_ips_1b" {
       value = ["${aws_eip.amqeip-1b.*.public_ip}"]
}

output "backend_appserver_eip_ips_1a" {
        value = ["${aws_eip.backend-appeip-1a.*.public_ip}"]
}

output "backend_appserver_eip_ips_1b" {
       value = ["${aws_eip.backend-appeip-1b.*.public_ip}"]
}

*/
