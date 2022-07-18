resource "azurerm_resource_group" "example" {
  name                        = "azurerm-monitor-diagnostic-correct"
  location                    = "southcentralus"

  tags                        = local.common_tags
}

