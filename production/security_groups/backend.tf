terraform {
  backend "s3" {
    bucket = "XXXXXXXXXXX"
    key    = "security_groups/key"
    region = "us-east-1"
    profile = "{$var.stack}"
	encrypt= "true"
  }
}
