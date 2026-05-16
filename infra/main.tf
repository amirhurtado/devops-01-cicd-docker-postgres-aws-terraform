terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "ec2_instance" {
    source = "terraform-aws-modules/ec2-instance/aws"
    version = "~> 6.0"

    name = "ec2-devops-instance"
    instance_type = "t3.micro"
    ami = var.ami_ubuntu_id
    key_name = var.key_name

    vpc_security_group_ids = [module.security_group.security_group_id]
    subnet_id = data.aws_subnets.default.ids[0]

    iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
}

 
 