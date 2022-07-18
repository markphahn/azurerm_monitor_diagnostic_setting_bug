# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting

resource "azurerm_monitor_diagnostic_setting" "edw_monitor_adf_ingestion" {
  name                          = "correct-diagnostics-adf-igestion"
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

  log {
    category                    = "PipelineRuns"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "TriggerRuns"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }


  log {
    category                    = "SandboxActivityRuns"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SandboxPipelineRuns"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISPackageEventMessages"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISPackageExecutableStatistics"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISPackageEventMessageContext"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISPackageExecutionComponentPhases"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISPackageExecutionDataStatistics"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISIntegrationRuntimeLogs"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  metric {
    category                    = "AllMetrics"
    enabled                     = true
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }
}
