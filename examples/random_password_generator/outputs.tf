output "objects" {
  value = tomap(
    {
      (var.landingzone.key) = {
        random_passwords = try(random_password.this, {})
      }
    }
  )
  sensitive = true
}
