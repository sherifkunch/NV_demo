data "aws_availability_zones" "available" {}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name                 = "education"
  cidr                 = "10.0.0.0/16"
  azs                  = data.aws_availability_zones.available.names
  public_subnets       = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_db_subnet_group" "education" {
  name       = "education"
  subnet_ids = module.vpc.public_subnets

  tags = {
    Name = "Education"
  }
}

resource "aws_security_group" "rds" {
  name   = "education_rds"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "education_rds"
  }
}

resource "aws_db_parameter_group" "education" {
  name   = "education"
  family = "postgres13"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

resource "aws_db_instance" "rds_postgres" {
  identifier             = var.identifier
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "13.1"
  username               = var.username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.education.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  parameter_group_name   = aws_db_parameter_group.education.name
  publicly_accessible    = true
  skip_final_snapshot    = true
  
  lifecycle {
    ignore_changes = [password]
  }
}

resource "aws_ssm_parameter" "default_postgres_ssm_parameter_identifier" {
  count = var.enabled_ssm_parameter_store ? 1 : 0

  name  = format("/rds/db/%s/identifier", var.identifier)
  value = var.identifier
  type  = "String"
  tags  = var.tags

  overwrite = true
}

resource "aws_ssm_parameter" "default_postgres_ssm_parameter_endpoint" {
  count = var.enabled_ssm_parameter_store ? 1 : 0

  name  = format("/rds/db/%s/endpoint", var.identifier)
  value = aws_db_instance.rds_postgres.endpoint
  type  = "String"
  tags  = var.tags

  overwrite = true
}


resource "aws_ssm_parameter" "default_postgres_ssm_parameter_username" {
  count = var.enabled_ssm_parameter_store ? 1 : 0

  name  = format("/rds/db/%s/superuser/username", var.identifier)
  value = var.username
  type  = "String"
  tags  = var.tags

  overwrite = true
}

resource "aws_ssm_parameter" "default_postgres_ssm_parameter_password" {
  count = var.enabled_ssm_parameter_store ? 1 : 0

  name  = format("/rds/db/%s/superuser/password", var.identifier)
  value = aws_db_instance.rds_postgres.password
  type  = "String"
  tags  = var.tags

  overwrite = true
}
