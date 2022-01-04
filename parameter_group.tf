resource "aws_db_parameter_group" "this" {
  name        = lower("${var.name}-parameter-group")
  description = "Parameter group for instance ${var.name}"
  family      = var.parameter_group_family
  tags        = var.tags


  dynamic "parameter" {
    for_each = { for parameter in var.db_parameters : parameter.name => parameter }
    content {
      name         = parameter.value["name"]
      value        = parameter.value["value"]
      apply_method = parameter.value["apply_method"] # "immediate"  or "pending-reboot"
    }
  }
  
}
