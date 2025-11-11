resource "azurerm_key_vault" "vault" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = var.sku_name
  enable_rbac_authorization     = var.enable_rbac_authorization
  tags                          = var.tags
  public_network_access_enabled = var.public_network_access_enabled
  purge_protection_enabled      = var.purge_protection_enabled

  lifecycle {
    ignore_changes = [
      tags["createdDate"]
    ]
  }
}

/*
resource "azurerm_management_lock" "vault_lock" {
  name       = "${var.name}_lock"
  scope      = azurerm_key_vault.vault.id
  lock_level = "CanNotDelete"
  notes      = "Locked to prevent deletion"
}
*/

# Get at the data for the vault resource for catagories of diag logs
data "azurerm_monitor_diagnostic_categories" "vault_cate" {
  resource_id = azurerm_key_vault.vault.id
}

resource "azurerm_monitor_diagnostic_setting" "vault_diag" {
  name                           = "${var.name}-diag"
  target_resource_id             = azurerm_key_vault.vault.id
  storage_account_id             = var.diag_storage_id
  
  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.vault_cate.log_category_types
    content {
      category = log.value
      enabled  = true
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.vault_cate.metrics
    content {
      category = metric.value
      enabled  = true
    }
  }

  lifecycle {
    ignore_changes = [
      log,
      metric
    ]
  }
}
