locals {
  tag_project                 = "monitor_diagnostic_setting_bug"

  common_tags = {
    "Project"                 = "monitor_diagnostic_setting_bug"
    "Purpose"                 = "Demonstrate bug with terraform monitor_diagnostic_setting - correct usage"
    "Documentation"           = "https://github.com/markphahn/azurerm_monitor_diagnostic_setting_bug"
  }
}

