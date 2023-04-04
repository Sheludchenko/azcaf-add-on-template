# Output with single instance
#
# output "objects" {
#   value = tomap(
#     {
#       (var.landingzone.key) = {
#         <resource_type_name> = try({
#           property_to_output = resource.name.property
#         }, {})
#       }
#     }
#   )
#   sensitive = true
# }
