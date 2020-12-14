# TODO: Designate a cloud provider, region, and credentials

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}
provider "aws" {
  region                  = "us-east-1"
}

# TODO: provision 4 AWS t2.micro EC2 instances named Udacity T2

resource "aws_instance" "Udacity_T2" {
  ami           = "ami-04d29b6f966df1537"
  subnet_id     = "subnet-06bc3c27"
  count         = "4"
  instance_type = "t2.micro"
  tags = {
    Name = "Udacity T2"
  }
}

# TODO: provision 2 m4.large EC2 instances named Udacity M4

resource "aws_instance" "Udacity-M4" {
  ami           =  "ami-04d29b6f966df1537"
  subnet_id     =  "subnet-06bc3c27"
  instance_type = "m4.large"
  count         = 2
  tags = {
    Name = "Udacity M4"
  }
}
