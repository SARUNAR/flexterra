variable "aws_region" {}

variable "stack"{
    default = "sandbox"
}
variable "security_groups"{
	type = "list"
 

	default = ["epic-AMQ","epic-AppServer","epic-ReceiptDB"]

}

