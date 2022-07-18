resource "azurerm_resource_group" "example" {
  name                        = "azurerm-monitor-diagnostic-incorrect"
  location                    = "southcentralus"

  tags                        = local.common_tags
}

