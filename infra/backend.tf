terraform {
  backend "s3" {
    bucket         = "your-tf-state-bucket"
    key            = "ecs/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}
