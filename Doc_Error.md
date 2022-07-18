# Documentation error description

This appears to be a documentation error, as pointed out by my son. It
appears that if a given resource has the ability to set several
`azurerm_monitor_diagnostic_setting` categories, then they all must be
set in the `azurerm_monitor_diagnostic_setting` resource definition.

For example, for a data factory resource, you can
list the categories of diagnostic categories available"
```
az monitor diagnostic-settings categories list --resource /subscriptions/<subscription id>/resourceGroups/edw-dev-azurerm-monitor-diagnostic-setting-bug/providers/Microsoft.DataFactory/factories/edw-dev-factory 
```
or, to get just the category names:
```
az monitor diagnostic-settings categories list --resource /subscriptions/<subscription id>/resourceGroups/edw-dev-azurerm-monitor-diagnostic-setting-bug/providers/Microsoft.DataFactory/factories/edw-dev-factory | grep name
      "name": "ActivityRuns",
      "name": "PipelineRuns",
      "name": "TriggerRuns",
      "name": "SandboxPipelineRuns",
      "name": "SandboxActivityRuns",
      "name": "SSISPackageEventMessages",
      "name": "SSISPackageExecutableStatistics",
      "name": "SSISPackageEventMessageContext",
      "name": "SSISPackageExecutionComponentPhases",
      "name": "SSISPackageExecutionDataStatistics",
      "name": "SSISIntegrationRuntimeLogs",
      "name": "AllMetrics",
```

See:
https://docs.microsoft.com/en-us/cli/azure/monitor/diagnostic-settings/categories?view=azure-cli-latest#az-monitor-diagnostic-settings-categories-list

Each of those items must be specified in your
`azurerm_monitor_diagnostic_setting` resource. If you do not provide
an explicit setting, then the terraform provdier will set reasonable
defaults. But then the next time it reads you defintion (during plan)
the defaults will not match what is in your resource definition. 

E.g. I fixed my `azurerm_monitor_diagnostic_setting` resource setting for
my data factory resource by changing it from this

```
resource "azurerm_monitor_diagnostic_setting" "edw_monitor_adf_ingestion" {
  name                          = "edw-dev-diagnostics-adf-igestion"
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
```
to this:
```
resource "azurerm_monitor_diagnostic_setting" "edw_monitor_adf_ingestion" {
  name                          = "edw-dev-diagnostics-adf-igestion"
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
    enabled                     = fales
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "TriggerRuns"
    enabled                     = fales
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }


  log {
    category                    = "SandboxActivityRuns"
    enabled                     = fales
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SandboxPipelineRuns"
    enabled                     = fales
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISPackageEventMessages"
    enabled                     = fales
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISPackageExecutableStatistics"
    enabled                     = fales
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISPackageEventMessageContext"
    enabled                     = fales
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISPackageExecutionComponentPhases"
    enabled                     = fales
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISPackageExecutionDataStatistics"
    enabled                     = fales
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  log {
    category                    = "SSISIntegrationRuntimeLogs"
    enabled                     = fales
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }

  metric {
    category                    = "AllMetrics"
    enabled                     = fales
    retention_policy {
      days                      = 0
      enabled                   = false
    }
  }
}
```

By fully specifing a value for each category I was able to have a
specific definition in my `azurerm_monitor_diagnostic_setting`
resource which matched the actual Azure definition set by the
provider. 



This `azurerm_monitor_diagnostic_setting` resource, when applied set
default values for any other catetories listed in the `az monitor diagnostic-settings categories list`
command above. That is, default settings will be create for
`PipelineRuns`, `TriggerRuns` and all the rest.

Once you set your single category, you can check the settings that
have be applied to your `azurerm_monitor_diagnostic_setting` using the
`az monitor diagnostic-settings list` command. E.g.
```
az monitor diagnostic-settings list --resource /subscriptions/<subscription id>/resourceGroups/edw-dev-azurerm-monitor-diagnostic-setting-bug/providers/Microsoft.DataFactory/factories/edw-dev-factory
```

For example I would see these settings for `PipelineRuns`:
```
        {
          "category": "PipelineRuns",
          "categoryGroup": null,
          "enabled": false,
          "retentionPolicy": {
            "days": 0,
            "enabled": false
          }
        },

```
Even though no such definiton exists in my file.
