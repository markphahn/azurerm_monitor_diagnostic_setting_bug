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

  # https://docs.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=terraform#2-configure-remote-state-storage-account
/*

  backend "azurerm" {
    resource_group_name  = "infra"
    storage_account_name = "markphahnbugterraformstate"
    container_name       = "terraform-tfstate"

    use_microsoft_graph  = true
    # verify this key name matches the envrionment name found
    # in the use-edw-module.tf file
    key                  = "dev.tfstate"
  }
*/
}

provider "azurerm" {
  features {}
}

