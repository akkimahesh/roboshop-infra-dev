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
resource "aws_security_group_rule" "mongodb_vpn" {
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

#openvpn
resource "aws_security_group_rule" "vpn_home" {
  security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "-1"
  cidr_blocks = ["0.0.0.0/0"] #ideally your home public IP address, but it frequently changes
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

resource "aws_security_group_rule" "app_alb_catalogue" {
  source_security_group_id = module.catalogue.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_cart" {
  source_security_group_id = module.cart.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

resource "aws_security_group_rule" "app_alb_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = module.app_alb.sg_id
}

#real configuration
resource "aws_security_group_rule" "web_alb_internet" {
  cidr_blocks = ["0.0.0.0/0"]
  type                     = "ingress"
  from_port                = 443
  to_port                  = 443
  protocol                 = "tcp"
  security_group_id        = module.web_alb.sg_id
}

resource "aws_security_group_rule" "mongodb_catalogue" {
  source_security_group_id = module.catalogue.sg_id
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
}

resource "aws_security_group_rule" "mongodb_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 27017
  to_port                  = 27017
  protocol                 = "tcp"
  security_group_id        = module.mongodb.sg_id
}

resource "aws_security_group_rule" "redis_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_user" {
  source_security_group_id = module.user.sg_id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "redis_cart" {
  source_security_group_id = module.cart.sg_id
  type                     = "ingress"
  from_port                = 6379
  to_port                  = 6379
  protocol                 = "tcp"
  security_group_id        = module.redis.sg_id
}

resource "aws_security_group_rule" "mysql_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}

resource "aws_security_group_rule" "mysql_shipping" {
  source_security_group_id = module.shipping.sg_id
  type                     = "ingress"
  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  security_group_id        = module.mysql.sg_id
}


resource "aws_security_group_rule" "rabbitmq_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "rabbitmq_payment" {
  source_security_group_id = module.payment.sg_id
  type                     = "ingress"
  from_port                = 5672
  to_port                  = 5672
  protocol                 = "tcp"
  security_group_id        = module.rabbitmq.sg_id
}

resource "aws_security_group_rule" "catalogue_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "catalogue_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.catalogue.sg_id
}

resource "aws_security_group_rule" "user_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "user_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.user.sg_id
}

resource "aws_security_group_rule" "cart_vpn" {
  source_security_group_id = module.vpn.sg_id
  type                     = "ingress"
  from_port                = 22
  to_port                  = 22
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}

resource "aws_security_group_rule" "cart_app_alb" {
  source_security_group_id = module.app_alb.sg_id
  type                     = "ingress"
  from_port                = 8080
  to_port                  = 8080
  protocol                 = "tcp"
  security_group_id        = module.cart.sg_id
}





