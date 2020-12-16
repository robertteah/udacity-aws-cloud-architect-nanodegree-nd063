terraform {
  backend "s3" {
    bucket = "udacity-aws-tfstate-1"
    key    = "lambda/terraform.tfstate"
    region = "us-east-1"
  }
}