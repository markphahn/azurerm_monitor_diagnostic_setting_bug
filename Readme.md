# Demonstration oof bug with `azurerm_monitor_diagnostic_setting`

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
The second invoocation of `terraform plan` will show that it has decided that 
`azurerm_monitor_diagnostic_setting.edw_monitor_adf_ingestion_activties will be updated in-place`
and also `azurerm_monitor_diagnostic_setting.edw_monitor_adf_ingestion_metrics will be updated in-place`.

You can endlessly run:
```
terraform plan
terraform apply
```
and these `azurerm_monitor_diagnostic_setting` resources will still be scheduled
for updating.

