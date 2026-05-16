module "s3_bucket" {
   source = "terraform-aws-modules/s3-bucket/aws"
   version = "~> 5.0"

   bucket = "devops-amir-s3-bucket"
   force_destroy = true
}