variable "ami_ubuntu_id" {
  description = "The AMI ID for the Ubuntu 26.04 instance"
  default = "ami-091138d0f0d41ff90"
}

variable "key_name" {
    description = "The name of the AWS key pair to use for SSH access"
    default = "awskey"
}