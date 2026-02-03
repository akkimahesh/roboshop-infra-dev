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

variable "zone_id" {
  type    = string
  default = "Z0993234WYJDRAX7W9PF"
}

variable "zone_name" {
  type    = string
  default = "maheshakki.shop"
}