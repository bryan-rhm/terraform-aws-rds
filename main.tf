# Random string to use as master password unless one is specified
resource "random_password" "master_password" {
  special = false
  length  = 16

  keepers  = {
    static = "1"
  }
}

resource "aws_db_subnet_group" "this" {
  count       = var.db_subnet_group_name == null ? 1 : 0
  name        = var.name
  description = "Subnet group for ${var.name} rds"
  subnet_ids  = var.subnet_ids
  tags        = var.tags
}

resource "aws_db_instance" "this" {
  iops                            = var.iops
  name                            = var.database_name
  engine                          = local.engine
  multi_az                        = var.multi_az
  timezone                        = var.timezone
  username                        = local.username
  password                        = local.master_password
  identifier                      = var.name
  kms_key_id                      = var.kms_key_arn
  engine_version                  = local.engine_version
  instance_class                  = var.instance_class
  allocated_storage               = local.allocated_storage
  storage_encrypted               = local.storage_encrypted
  apply_immediately               = var.apply_immediately
  character_set_name              = var.character_set_name
  skip_final_snapshot             = false
  deletion_protection             = var.deletion_protection
  replicate_source_db             = var.replicate_source_db
  snapshot_identifier             = var.snapshot_identifier
  db_subnet_group_name            = local.db_subnet_group_name
  copy_tags_to_snapshot           = var.copy_tags_to_snapshot
  max_allocated_storage           = var.max_allocated_storage
  vpc_security_group_ids          = var.security_group_ids
  backup_retention_period         = var.backup_retention_period
  final_snapshot_identifier       = "${var.name}-${random_id.snapshot_identifier.hex}"
  auto_minor_version_upgrade      = var.auto_minor_version_upgrade
  allow_major_version_upgrade     = var.allow_major_version_upgrade
  enabled_cloudwatch_logs_exports = var.enabled_cloudwatch_logs_exports
  
  tags = var.tags

  lifecycle {
    ignore_changes = [
      engine_version
    ]
  }
}

resource "random_id" "snapshot_identifier" {
  keepers = {
    id = var.name
  }

  byte_length = 4
}

data "aws_iam_policy_document" "monitoring_rds_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "rds_enhanced_monitoring" {
  count               = var.monitoring_interval > 0 ? 1 : 0
  name                = "${title(var.name)}-RDSEnhancedMonitoringRole"
  assume_role_policy  = data.aws_iam_policy_document.monitoring_rds_assume_role.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"]
  tags                = var.tags
}


