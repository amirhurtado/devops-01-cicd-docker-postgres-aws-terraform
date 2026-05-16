resource "aws_iam_role" "ec2_role" {
    name = "devops-ec2-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17",
        Statement = [{
            Effect = "Allow"
            Principal = { Service = "ec2.amazonaws.com"}
            Action = "sts:AssumeRole"
        }]
        
    })
}

resource "aws_iam_role_policy" "ec2_s3_policy" {
    name = "devops-ec2-s3-policy"
    role = aws_iam_role.ec2_role.id
    policy = jsonencode({
        Version = "2012-10-17",
        Statement = [ {
            Effect = "Allow"
            Action = [
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject"
            ]
            Resource = "arn:aws:s3:::devops-amir-s3-bucket/*"

        }]
    })
}

resource "aws_iam_instance_profile" "ec2_profile" {
    name = "devops-ec2-instance-profile"
    role = aws_iam_role.ec2_role.name
}