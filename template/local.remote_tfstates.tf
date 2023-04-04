locals {
  landingzone = {
    current = {
      storage_account_name = var.tfstate_storage_account_name
      container_name       = var.tfstate_container_name
      resource_group_name  = var.tfstate_resource_group_name
    }
    lower = {
      storage_account_name = var.lower_storage_account_name
      container_name       = var.lower_container_name
      resource_group_name  = var.lower_resource_group_name
    }
  }
}

data "terraform_remote_state" "remote" {
  for_each = try(var.landingzone.tfstates, {})

  backend = var.landingzone.backend_type
  config = {
    storage_account_name = local.landingzone[try(each.value.level, "current")].storage_account_name
    container_name       = local.landingzone[try(each.value.level, "current")].container_name
    resource_group_name  = local.landingzone[try(each.value.level, "current")].resource_group_name
    subscription_id      = var.tfstate_subscription_id
    key                  = each.value.tfstate
  }
}

locals {
  landingzone_tag = {
    "landingzone" = var.landingzone.key
  }

  global_settings = merge(
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].global_settings, null),
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.global_settings, null)
  )

  diagnostics = merge(
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.objects[var.landingzone.global_settings_key].diagnostics, null),
    try(data.terraform_remote_state.remote[var.landingzone.global_settings_key].outputs.diagnostics, null)
  )

  remote = {
    global_settings = local.global_settings
    diagnostics     = local.diagnostics


    # Resources that need to be referenced in add-on
    #
    # <resource_type> = {
    #   for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].<resource_type>, {}))
    # }

    # Resource types can be found in local.<resource_category>.tf under caf_solution in https://github.com/Azure/caf-terraform-landingzones repository.
    # It may vary from version to version.

    # Here's what it will look like for AKS clusters:
    #
    # aks_clusters = {
    #   for key, value in try(var.landingzone.tfstates, {}) : key => merge(try(data.terraform_remote_state.remote[key].outputs.objects[key].aks_clusters, {}))
    # }

    # Later it can be referenced with the following code:
    # local.remote.aks_clusters[var.<add_on_configuration>.aks_cluster.lz_key][var.<add_on_configuration>.aks_cluster.key].<property>
  }
}
