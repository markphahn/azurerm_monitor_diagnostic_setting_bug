# Demonstration of bug with `azurerm_monitor_diagnostic_setting`

## Problem

When using the Terraform `azurerm` provider and attempting to
create/manage `azurerm_monitor_diagnostic_setting` resources (to tell
an Azure resource too send logs to Log Analytics, for instance) the
module will always attempt to change any
`azurerm_monitor_diagnostic_setting` resources defined.

Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting

## Reproduce Steps

To reproduce do the following:

#1 Check out this repository and `cd` into the `incorrect-definition` direcotry

#2 Run `terraform init` in this directory.

#2 Run these commands:
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

## Solution

You need to fully specify all the possible diagnostic catetories in
the `azurerm_monitor_diagnostic_setting` resource definition in
terraform. See the `correct_definition` folder, like this:

#1 `cd` to the `correct_definition` 

#2 Run `terraform init`

#3 Run these commands:
```
terraform plan
terraform apply
# then again
terraform plan
```

In this example the second `terraform plan` will show no needed changes.


This appears to be a documenation error. All diagnostic categories
need to be specified in the resource definition. See the file
[Doc_Error.md](Doc_Error.md).

## Other explanation

This could still be a bug in the provider and fully specifing all the
different categories just a mitigation. 

That is, the provider should presume that unspecified settings have
the default value the provider will set, instead of the `null`
value. Thus, when comparing an unpsecificed category to the actualy
Azure settings, they would match; whereas the `null`s used now do not
match.

## More information

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

Even though no such definiton exists in my incorrect resource
definition file.

## Cross reference

See: https://github.com/hashicorp/terraform-provider-azurerm/issues/17172
