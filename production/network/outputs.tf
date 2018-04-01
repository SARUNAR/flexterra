output "epic_vpc_id" {
  value = "${aws_vpc.vpc_epic.id}"
}

data "aws_subnet_ids" "private" {
  vpc_id = "${aws_vpc.vpc_epic.id}"
  tags {
    Tier = "Private"
  }
}

output "private_subnet_ids" {
  value = ["${data.aws_subnet_ids.private.ids}"]
}

output "private_subnet_id_east_1a" {
  value = "${aws_subnet.private_1_subnet_us_east_1a.id}"
}
output "private_subnet_id_east_1b" {
  value = "${aws_subnet.private_1_subnet_us_east_1b.id}"
}
output "private_subnet_id_east_1c" {
  value = "${aws_subnet.private_1_subnet_us_east_1c.id}"
}
output "private_subnet_id_east_1d" {
  value = "${aws_subnet.private_1_subnet_us_east_1d.id}"
}

data "aws_subnet_ids" "public" {
  vpc_id = "${aws_vpc.vpc_epic.id}"
  tags {
    Tier = "Public"
  
 }
}
output "public_subnet_ids" {
  value = ["${data.aws_subnet_ids.public.ids}"]
}

output "public_subnet_id_east_1a" {
  value = "${aws_subnet.public_subnet_us_east_1a.id}"
}

output "public_subnet_id_east_1b" {
  value = "${aws_subnet.public_subnet_us_east_1b.id}"
}

output "public_subnet_id_east_1c" {
  value = "${aws_subnet.public_subnet_us_east_1c.id}"
}

output "public_subnet_id_east_1d" {
  value = "${aws_subnet.public_subnet_us_east_1d.id}"
}
