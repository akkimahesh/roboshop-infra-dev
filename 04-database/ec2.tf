module "redis" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = "${local.ec2_name}-redis"
  ami                    = data.aws_ami.centos8.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    var.ec2_tags,
    {
      Name = "${local.ec2_name}-redis"
    }
  )
}

resource "null_resource" "redis" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.redis.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.redis.private_ip
    type = "ssh"
    user = "centos"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis dev"
    ]
  }
}

module "redis" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = "${local.ec2_name}-redis"
  ami                    = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.redis_sg_id.value]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    var.ec2_tags,
    {
      Name = "${local.ec2_name}-redis"
    }
  )
}

resource "null_resource" "redis" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.redis.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.redis.private_ip
    type = "ssh"
    user = "centos"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh redis dev"
    ]
  }
}

module "mysql" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = "${local.ec2_name}-mysql"
  ami                    = data.aws_ami.centos8.id
  instance_type          = "t3.small"
  vpc_security_group_ids = [data.aws_ssm_parameter.mysql_sg_id.value]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    var.ec2_tags,
    {
      Name = "${local.ec2_name}-mysql"
    }
  )
}

resource "null_resource" "mysql" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.mysql.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.mysql.private_ip
    type = "ssh"
    user = "centos"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh mysql dev"
    ]
  }
}

module "rabbitmq" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  name                   = "${local.ec2_name}-rabbitmq"
  ami                    = data.aws_ami.centos8.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [data.aws_ssm_parameter.rabbitmq_sg_id.value]
  subnet_id              = local.database_subnet_id

  tags = merge(
    var.common_tags,
    var.ec2_tags,
    {
      Name = "${local.ec2_name}-rabbitmq"
    }
  )
}

resource "null_resource" "rabbitmq" {
  # Changes to any instance of the cluster requires re-provisioning
  triggers = {
    instance_id = module.rabbitmq.id
  }

  # Bootstrap script can run on any instance of the cluster
  # So we just choose the first in this case
  connection {
    host = module.rabbitmq.private_ip
    type = "ssh"
    user = "centos"
    password = "DevOps321"
  }

  provisioner "file" {
    source      = "bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }

  provisioner "remote-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    inline = [
      "chmod +x /tmp/bootstrap.sh",
      "sudo sh /tmp/bootstrap.sh rabbitmq dev"
    ]
  }
}



module "records" {
  source  = "terraform-aws-modules/route53/aws"
  version = "~> 6.4"

  create_zone = false

  records = {
    redis = {
      zone_id = var.zone_id
      name    = "redis-dev"
      type    = "A"
      ttl     = 1
      records = [
        module.redis.private_ip
      ]
    },
    mysql = {
      zone_id = var.zone_id
      name    = "mysql-dev"
      type    = "A"
      ttl     = 1
      records = [
        module.mysql.private_ip
      ]
    },
    redis = {
      zone_id = var.zone_id
      name    = "redis-dev"
      type    = "A"
      ttl     = 1
      records = [
        module.redis.private_ip
      ]
    },
    rabbitmq = {
      zone_id = var.zone_id
      name    = "rabbitmq-dev"
      type    = "A"
      ttl     = 1
      records = [
        module.rabbitmq.private_ip
      ]
    }
  }
}






# resource "aws_route53_record" "mysql" {
#   zone_id = var.zone_id
#   name    = "mysql.maheshakki.shop"
#   type    = "A"
#   ttl     = 1
#   records = [module.web.public_ip]
# }

# output "private_ip" {
#     value = module.ec2_instance.private_ip

# }