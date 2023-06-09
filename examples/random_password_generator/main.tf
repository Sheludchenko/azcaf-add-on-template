terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.99.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.2.0"
    }
  }
  required_version = ">= 0.13"
}
