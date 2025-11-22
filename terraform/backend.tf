# terraform {
#   backend "s3" {
#     bucket         = "your-terraform-state-bucket"
#     key            = "project3/rds/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform-locks"
#   }
# }
