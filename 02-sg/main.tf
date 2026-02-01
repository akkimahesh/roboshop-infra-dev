module "mongodb" {
  source         = "../../terraform-aws-security-group"
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
  source         = "../../terraform-aws-security-group"
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
  source         = "../../terraform-aws-security-group"
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
  source         = "../../terraform-aws-security-group"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for RabbitMQ servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "rabbitmq-sg"
  # sg_ingress_rules = var.mogodb_ingress_rules
}

module "cart" {
  source         = "../../terraform-aws-security-group"
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
  source         = "../../terraform-aws-security-group"
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
  source         = "../../terraform-aws-security-group"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for payments servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "payments-sg"
  # sg_ingress_rules = var.mogodb_ingress_rules
}

module "dispatch" {
  source         = "../../terraform-aws-security-group"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for dispatch servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "dispatch-sg"
  # sg_ingress_rules = var.catalogue_ingress_rules
}

module "user" {
  source         = "../../terraform-aws-security-group"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for user servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "user-sg"
  # sg_ingress_rules = var.user_ingress_rules
}

module "catalogue" {
  source         = "../../terraform-aws-security-group"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for catalogue servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "catalogue-sg"
  # sg_ingress_rules = var.catalogue_ingress_rules
}

module "web" {
  source         = "../../terraform-aws-security-group"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for web servers"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "web-sg"
  # sg_ingress_rules = var.web_ingress_rules
}

module "openvpn" {
  source         = "../../terraform-aws-security-group"
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
  source         = "../../terraform-aws-security-group"
  vpc_id         = data.aws_ssm_parameter.vpc_id.value
  sg_description = "Security group for app_alb"
  common_tags    = var.common_tags
  sg_tags        = var.sg_tags
  project_name   = var.project_name
  environment    = var.environment
  sg_name        = "app_alb"
  # sg_ingress_rules = var.web_ingress_rules
}

resource "aws_security_group_rule" "mongodb_from_catalogue" {
  source_security_group_id = module.catalogue.sg_id
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_from_openvpn" {
  source_security_group_id = module.openvpn.sg_id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_from_user" {
  source_security_group_id = module.user.sg_id
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  security_group_id = module.mongodb.sg_id
}

resource "aws_security_group_rule" "redis_from_cart" {
  source_security_group_id = module.cart.sg_id
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_from_user" {
  source_security_group_id = module.user.sg_id
  type              = "ingress"
  from_port         = 6379
  to_port           = 6379
  protocol          = "tcp"
  security_group_id = module.redis.sg_id
}

resource "aws_security_group_rule" "mysql_from_shipping" {
  source_security_group_id = module.shipping.sg_id
  type              = "ingress"
  from_port         = 3306
  to_port           = 3306
  protocol          = "tcp"
  security_group_id = module.mysql.sg_id
}

resource "aws_security_group_rule" "rabbitmq_from_payments" {
  source_security_group_id = module.payments.sg_id
  type              = "ingress"
  from_port         = 5672
  to_port           = 5672
  protocol          = "tcp"
  security_group_id = module.mysql.sg_id
}

resource "aws_security_group_rule" "openvpn" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "all"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.openvpn.sg_id
}

resource "aws_security_group_rule" "catalogue_from_alb" {
  source_security_group_id = module.app_alb.sg_id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "cart_from_alb" {
  source_security_group_id = module.app_alb.sg_id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.cart.sg_id
}

resource "aws_security_group_rule" "user_from_alb" {
  source_security_group_id = module.app_alb.sg_id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.user.sg_id
}

resource "aws_security_group_rule" "shipping_from_alb" {
  source_security_group_id = module.app_alb.sg_id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.shipping.sg_id
}

resource "aws_security_group_rule" "payments_from_alb" {
  source_security_group_id = module.app_alb.sg_id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.payments.sg_id
}

resource "aws_security_group_rule" "dispatch_from_alb" {
  source_security_group_id = module.app_alb.sg_id
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  security_group_id = module.dispatch.sg_id
}

resource "aws_security_group_rule" "web" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = module.catalogue.sg_id
}

resource "aws_security_group_rule" "alb" {
  source_security_group_id = module.web.sg_id
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = module.app_alb.sg_id
}