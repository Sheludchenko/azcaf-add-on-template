terraform {
  required_providers {
    # Required for azurerm Terraform backend to fuction propertly
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99.0"
    }
    # Addtional providers goes here
  }
  # Terraform version requiremts if needed
  # required_version = ">= 0.13"
}
