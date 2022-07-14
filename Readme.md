# Demonstration of bug with `azurerm_monitor_diagnostic_setting`

## Problem

This module will always attempt to change any `azurerm_monitor_diagnostic_setting`
resources defined. 

To reproduce do the following:
```
terraform plan
terraform apply
# then again
terraform plan
```

The first run of plan/apply will create all the resources properly, including 
the `azurerm_monitor_diagnostic_setting` resource.

The second invocation of `terraform plan` will show that it has decided that 
`azurerm_monitor_diagnostic_setting.edw_monitor_adf_ingestion_activties will be updated in-place`
and also `azurerm_monitor_diagnostic_setting.edw_monitor_adf_ingestion_metrics will be updated in-place`
(see below for the full plan output).

You can endlessly run:
```
terraform plan
terraform apply
```
and these `azurerm_monitor_diagnostic_setting` resources will still be scheduled
for updating.

This is the output produced by `terraform plan`, no matter how many times you 
proceed through a plan/apply cycle:

```
Terraform will perform the following actions:

  # azurerm_monitor_diagnostic_setting.edw_monitor_adf_ingestion_activties will be updated in-place
  ~ resource "azurerm_monitor_diagnostic_setting" "edw_monitor_adf_ingestion_activties" {
        id                             = "/subscriptions/9f6fb1f5-8793-4b9f-9eec-7cbdb4e910d8/resourceGroups/edw-dev-azurerm-monitor-diagnostic-setting-bug/providers/Microsoft.DataFactory/factories/edw-dev-factory|edw-dev-diagnostics-adf-igestion-activities"
        name                           = "edw-dev-diagnostics-adf-igestion-activities"
        # (3 unchanged attributes hidden)

      - log {
          - category = "ActivityRuns" -> null
          - enabled  = true -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      + log {
          + category = "ActivityRuns"
          + enabled  = true
        }
      - log {
          - category = "PipelineRuns" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISIntegrationRuntimeLogs" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISPackageEventMessageContext" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISPackageEventMessages" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISPackageExecutableStatistics" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISPackageExecutionComponentPhases" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISPackageExecutionDataStatistics" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SandboxActivityRuns" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SandboxPipelineRuns" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "TriggerRuns" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }

      - metric {
          - category = "AllMetrics" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
    }

  # azurerm_monitor_diagnostic_setting.edw_monitor_adf_ingestion_metrics will be updated in-place
  ~ resource "azurerm_monitor_diagnostic_setting" "edw_monitor_adf_ingestion_metrics" {
        id                             = "/subscriptions/9f6fb1f5-8793-4b9f-9eec-7cbdb4e910d8/resourceGroups/edw-dev-azurerm-monitor-diagnostic-setting-bug/providers/Microsoft.DataFactory/factories/edw-dev-factory|edw-dev-diagnostics-adf-igestion-metrics"
        name                           = "edw-dev-diagnostics-adf-igestion-metrics"
        # (3 unchanged attributes hidden)

      - log {
          - category = "ActivityRuns" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "PipelineRuns" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISIntegrationRuntimeLogs" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISPackageEventMessageContext" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISPackageEventMessages" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISPackageExecutableStatistics" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISPackageExecutionComponentPhases" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SSISPackageExecutionDataStatistics" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SandboxActivityRuns" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "SandboxPipelineRuns" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      - log {
          - category = "TriggerRuns" -> null
          - enabled  = false -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }

      - metric {
          - category = "AllMetrics" -> null
          - enabled  = true -> null

          - retention_policy {
              - days    = 0 -> null
              - enabled = false -> null
            }
        }
      + metric {
          + category = "AllMetrics"
          + enabled  = true
        }
    }

Plan: 0 to add, 2 to change, 0 to destroy.


```
