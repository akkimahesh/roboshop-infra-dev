module "mongodb" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for MongoDB servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "mongodb-sg"
  # sg_ingress_rules = var.mogodb_ingress_rules
}

module "redis" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for Redis servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "redis-sg"
  # sg_ingress_rules = var.mogodb_ingress_rules
}

module "mysql" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for MySQL servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "mysql-sg"
  # sg_ingress_rules = var.mysql_ingress_rules
}

module "rabbitmq" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for RabbitMQ servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "rabbitmq-sg"
  # sg_ingress_rules = var.mogodb_ingress_rules
}

module "catalogue" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for catalogue servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "catalogue-sg"
  # sg_ingress_rules = var.mogodb_ingress_rules
}

module "user" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for user servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "user-sg"
  # sg_ingress_rules = var.mogodb_ingress_rules
}

module "cart" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for cart servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "cart-sg"
  # sg_ingress_rules = var.mogodb_ingress_rules
}

module "shipping" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for shipping servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "shipping-sg"
  # sg_ingress_rules = var.mogodb_ingress_rules
}

module "payments" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for payments servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "payments-sg"
  # sg_ingress_rules = var.mogodb_ingress_rules
}

module "vpn" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_vpc.default.id
  sg_description = "Security group for openvpn servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "openvpn-sg"
  # sg_ingress_rules = var.web_ingress_rules
}

module "app_alb" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for app_alb"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "app_alb"
  # sg_ingress_rules = var.web_ingress_rules
}

module "web_alb" {
  source         = "git::https://github.com/akkimahesh/terraform-aws-security-group.git?ref=main"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for web_alb"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "web_alb"
  # sg_ingress_rules = var.web_ingress_rules
}
resource "aws_security_group_rule" "mongodb_from_openvpn" {
  source_security_group_id = module.vpn.sg_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.mongodb.sg_id
}
resource "aws_security_group_rule" "mongodb" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "vpn" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
}

resource "aws_security_group_rule" "app_alb_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_web" {
  source_security_group_id = module.web.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

