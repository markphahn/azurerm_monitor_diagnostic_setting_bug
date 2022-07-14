resource "azurerm_data_factory" "edw_factory" {
  name                        = "edw-dev-factory" 
  location                    = azurerm_resource_group.rg.location
  resource_group_name         = azurerm_resource_group.rg.name

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

