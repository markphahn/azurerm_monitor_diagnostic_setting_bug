resource "azurerm_data_factory" "edw_factory" {
  name                        = "correct-factory" 
  location                    = azurerm_resource_group.example.location
  resource_group_name         = azurerm_resource_group.example.name

  managed_virtual_network_enabled = true

  global_parameter {
    name                      = "Environment"
    type                      = "String"
    value                     = upper(local.tag_project)
  }

  # managed_virtual_network_enabled = true
  identity {
    type                      = "SystemAssigned"
  }

  tags                        = local.common_tags

    lifecycle {
    ignore_changes = [
      vsts_configuration,
      global_parameter,
      tags,
    ]
  }

}

