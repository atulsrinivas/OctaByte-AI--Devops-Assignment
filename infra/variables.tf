variable "region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "octabyte-app"
}

variable "db_username" {}
variable "db_password" {
  sensitive = true
}
