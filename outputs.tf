output "output"{
  description = "AWS rds object"
  value = {
    rds          = aws_db_instance.this
    rds_password = local.master_password
  }
  sensitive = true
}