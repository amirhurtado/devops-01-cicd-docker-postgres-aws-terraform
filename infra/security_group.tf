module "group_security" {
    source = "terraform-aws-modules/security-group/aws"
    version = "~> 5.0"

    name = "sg-devops_instance"
    description = "Security group for EC2 instance"

    ingress_with_cidr_blocks = [
        {
            from_port = 22
            to_port = 22
            protocol = "tcp"
            description = "Allow SSH access"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port = 80
            to_port = 80
            protocol = "tcp"
            description = "Allow HTTP access"
            cidr_blocks = ["0.0.0.0/0"]
        },
        {
            from_port = 3000
            to_port = 3000
            protocol = "tcp"
            description = "Allow access to application on port 3000 for node app"
            cidr_blocks = ["0.0.0.0/0"]
        }
    ]

    egress_rules = ["all-all"]
}