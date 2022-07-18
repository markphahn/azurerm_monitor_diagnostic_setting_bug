# https://www.terraform.io/docs/language/settings/backends/configuration.html
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
terraform {

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"

      # Version as of 2022-07-13
      # https://registry.terraform.io/providers/hashicorp/azurerm/latest
      version = "=3.13.0"
    }
  }
}

provider "azurerm" {
  features {}
}

