# Documentation error description

This appears to be a documentation error, as pointed out by my
[son](https://github.com/GauntletWizard/).  It appears that if a given
resource has the ability to set several
`azurerm_monitor_diagnostic_setting` categories, then they all must be
set in the `azurerm_monitor_diagnostic_setting` resource definition.

For example, for a specific resource like my example data factory resource, you can
list the categories of diagnostic categories available:
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
the defaults will not match what is in your resource definition
(because your definition looks like it has nulls instead of the
default values). 

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
to this which specifies every posssible diagnostic category from the
category list from the `az` command above:
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

As a further example, using the firewall definition referenced in at
the beginning of this issue, you can find all the categories you need
to list for a firewall resource with this command:

```
 az monitor diagnostic-settings categories list --resource /subscriptions/<subscription id>/resourceGroups/edw-dev-azurerm-monitor-diagnostic-setting-bug/providers/Microsoft.Network/azureFirewalls/testfirewall | grep name
      "name": "AzureFirewallApplicationRule",
      "name": "AzureFirewallNetworkRule",
      "name": "AzureFirewallDnsProxy",
      "name": "AZFWNetworkRule",
      "name": "AZFWApplicationRule",
      "name": "AZFWNatRule",
      "name": "AZFWThreatIntel",
      "name": "AZFWIdpsSignature",
      "name": "AZFWDnsQuery",
      "name": "AZFWFqdnResolveFailure",
      "name": "AZFWApplicationRuleAggregation",
      "name": "AZFWNetworkRuleAggregation",
      "name": "AZFWNatRuleAggregation",
      "name": "AllMetrics",
```

For more information and a demonstration see:
https://github.com/markphahn/azurerm_monitor_diagnostic_setting_bug
