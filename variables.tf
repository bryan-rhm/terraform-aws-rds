variable "name" {
 description = "The name of the RDS instance, if omitted, Terraform will assign a random, unique identifier. Required if restore_to_point_in_time is specified."
 type        = string
 default     = null 
}

variable "username"{
  description = "(Required unless a snapshot_identifier or replicate_source_db is provided) Username for the master DB user."
  type        = string
  default     = "root"
}

variable "timezone" {
  description = "Time zone of the DB instance. timezone is currently only supported by Microsoft SQL Server. "
  type        = string
  default     = null
}

variable "security_group_ids"{
  description = "List of VPC security groups to associate."
  type        = list(string)
  default     = []
}

variable "instance_class" {
  description = "The instance type of the RDS instance."
  type        = string
  default     = "db.t3.micro"
}

variable "multi_az" {
  description = "Specifies if the RDS instance is multi-AZ"
  type        = bool
  default     = true
}

variable "database_name"{
  description = "The name of the database to create when the DB instance is created"
  type        = string
  default     = null
}

variable "kms_key_arn" {
  description = "The ARN for the KMS encryption key."
  type        = string
  default     = null
}

variable "iops" {
  description = "The amount of provisioned IOPS. Setting this implies a storage_type of io1, if not storage type is gp2"
  type        = number
  default     = 0
}

variable "engine" {
  description = "Required unless a snapshot_identifier or replicate_source_db is provided"
  type        = string
  default     = ""
}
 
variable "engine_version" {
  description = "The engine version to use."
  type        = string
  default     = null
}

variable "allocated_storage" {
  description = "this argument represents the initial storage allocation (Required unless a snapshot_identifier or replicate_source_db is provided)"
  type        = number
  default     = 20
}

variable "max_allocated_storage"{
  description = "When configured, the upper limit to which Amazon RDS can automatically scale the storage of the DB instance."
  type        = number
  default     = 0
}

variable "allow_major_version_upgrade" {
  description = "Indicates that major version upgrades are allowed."
  type        = bool
  default     = true
}

variable "auto_minor_version_upgrade" {
  description = "Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window"
  type        = bool
  default     = false
}

variable "apply_immediately" {
  description = "Specifies whether any database modifications are applied immediately, or during the next maintenance window"
  type        = bool
  default     = false
}

variable "backup_retention_period" {
  description = "The days to retain backups for. Must be between 0 and 35"
  type        = number
  default     = 14
}

variable "character_set_name" {
  description = "The character set name to use for DB encoding in Oracle and Microsoft SQL instances (collation). "
  type        = string
  default     = null
}

variable "copy_tags_to_snapshot" {
  description = "Copy all Instance tags to snapshots."
  type        = bool
  default     = true
}

variable "db_subnet_group_name" {
  description = "Name of DB subnet group. DB instance will be created in the VPC associated with the DB subnet group."
  type        = string
  default     = null
}

variable "subnet_ids" {
  description = "If no subnet group is specified you must specify the subnet ids where the rds will be placed"
  type        = list(string)
  default     = []
 }

variable "deletion_protection" {
  description = "If the DB instance should have deletion protection enabled."
  type        = bool
  default     = true
}

variable "enabled_cloudwatch_logs_exports" {
  description = "Set of log types to enable for exporting to CloudWatch logs. If omitted, no logs will be exported. Valid values (depending on engine). MySQL and MariaDB: audit, error, general, slowquery. PostgreSQL: postgresql, upgrade. MSSQL: agent , error. Oracle: alert, audit, listener, trace"
  type        = list(string)
  default     = null
}

variable "monitoring_interval" {
  description = "The interval, in seconds, between points when Enhanced Monitoring metrics are collected for the DB instance."
  type        = number
  default     = 0
}


variable "db_parameters" {
  description = "A list of DB parameters to apply."
  type        = list(object({
    name         = string
    value        = string
    apply_method = string 
    })) # apply_method = "immediate" (default), or "pending-reboot"
  default     = []
}

variable "parameter_group_family" {
  description = "The family of the DB parameter group."
  type        = string
}

variable "replicate_source_db" {
  description = "Specifies that this resource is a Replicate database, and to use this value as the source database. This correlates to the identifier of another Amazon RDS Database to replicate "
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to add to all resources"
  type        = map(any)
  default     = {}
}

variable "snapshot_identifier"{
  description = "Specifies whether or not to create this database from a snapshot"
  type        = string
  default     = null 
}