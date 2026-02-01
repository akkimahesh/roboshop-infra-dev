variable "common_tags" {
  default = {
    project_name = "roboshop"
    environment  = "dev"
    terraform    = "true"
  }
}

variable "vpc_tags" {
  default = {}
}

variable "project_name" {
  default = "roboshop"
}

variable "environment" {
  default = "dev"
}

variable "public_subnets_cidr" {
  default = ["13.0.1.0/24", "13.0.2.0/24"]
}

variable "private_subnets_cidr" {
  default = ["13.0.3.0/24", "13.0.4.0/24"]
}

variable "database_subnets_cidr" {
  default = ["13.0.5.0/24", "13.0.6.0/24"]
}

variable "is_peering_required" {
  default = true
}
