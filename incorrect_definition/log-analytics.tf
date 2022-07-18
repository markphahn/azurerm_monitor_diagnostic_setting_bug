# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/log_analytics_workspace

resource "azurerm_log_analytics_workspace" "edw_log_analytics_workspace" {
  name                          = "incorrect-log-analytics"
  location                      = azurerm_resource_group.example.location
  resource_group_name           = azurerm_resource_group.example.name

  sku                           = "PerGB2018"
  retention_in_days             = 60

  tags                          = local.common_tags
}
