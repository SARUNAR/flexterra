terraform {
  backend "s3" {
    bucket = "XXXXXXXXX"
    key    = "network/test"
    region = "us-east-1"
    profile = "sandbox"
	encrypt= "true"
  }
}
