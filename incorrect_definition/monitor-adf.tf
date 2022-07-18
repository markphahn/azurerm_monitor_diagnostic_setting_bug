# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting

resource "azurerm_monitor_diagnostic_setting" "edw_monitor_adf_ingestion" {
  name                          = "incorrect-diagnostics-adf-igestion"
  target_resource_id            = azurerm_data_factory.edw_factory.id

  log_analytics_workspace_id    = azurerm_log_analytics_workspace.edw_log_analytics_workspace.id
  log_analytics_destination_type = "Dedicated" # or null see [documentation][1]

  log {
    category                    = "ActivityRuns"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }
}
