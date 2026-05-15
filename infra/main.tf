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

module "ec2_instance" {
    source = "terraform-aws-modules/ec2-instance/aws"
    version = "~> 6.0"

    name = "ec2-devops_instance"
    instance_type = "t3.micro"
    ami = var.ami_ubuntu_id
    key_name = var.key_name

    vpc_security_group_ids = [module.group_security.security_group_id]
}

 