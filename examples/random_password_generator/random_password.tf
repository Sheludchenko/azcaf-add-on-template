resource "random_password" "this" {
  for_each = var.random_passwords

  length           = try(each.length, 16)
  lower            = try(each.lower, true)
  min_lower        = try(each.min_lower, null)
  upper            = try(each.upper, true)
  min_upper        = try(each.min_upper, null)
  numeric          = try(each.numeric, true)
  min_numeric      = try(each.min_numeric, null)
  special          = try(each.special, true)
  min_special      = try(each.min_special, null)
  override_special = try(each.override_special, null)
}
