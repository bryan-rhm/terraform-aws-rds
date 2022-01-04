locals {
  is_replica           = var.snapshot_identifier != null || var.replicate_source_db != null ? true : false
  engine               = local.is_replica ? null : var.engine
  username             = local.is_replica ? null : var.username
  engine_version       = local.is_replica ? null : var.engine_version
  master_password      = local.is_replica ? null : random_password.master_password.result
  allocated_storage    = local.is_replica ? null : var.allocated_storage
  storage_encrypted    = var.kms_key_arn != null ? true : false
  db_subnet_group_name = var.db_subnet_group_name == null ? aws_db_subnet_group.this[0].name : var.db_subnet_group_name
}
