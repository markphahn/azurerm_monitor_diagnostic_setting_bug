resource "azurerm_resource_group" "rg" {
  name                        = "edw-dev-azurerm-monitor-diagnostic-setting-bug"
  location                    = "southcentralus"

  tags                        = local.common_tags
}

