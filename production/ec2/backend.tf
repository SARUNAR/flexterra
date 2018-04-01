terraform {
  backend "s3" {
    bucket = "xxxxxxxxxxxxxx"
    key    = "ec2/key"
    region = "us-east-1"
    profile = "sandbox"
	encrypt= "true"
  }
}
