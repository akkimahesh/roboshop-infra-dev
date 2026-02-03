variable "common_tags" {
  default = {
    project_name = "roboshop"
    environment  = "dev"
    terraform    = "true"
  }
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "ec2_tags" {
  default = {}
}
