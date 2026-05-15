output "public_ip_ec2_instance" {
    value = module.ec2_instance.public_ip
    description = "The public IP address of the EC2 instance"
}