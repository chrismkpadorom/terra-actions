##
# Analytics Stroage Account Diagnotics Settings
##
resource "azurerm_monitor_diagnostic_setting" "stg_diag" {
  name               = "${module.stg.name}-diag"
  target_resource_id = module.stg.id
  eventhub_authorization_rule_id = data.azurerm_eventhub_namespace_authorization_rule.listen-send.id
  eventhub_name                  = local.st_logs_name
  
  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.stg.log_category_types
    content {
      category = enabled_log.value

    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.stg.metrics
    content {
      category = metric.value

    }
  }

  lifecycle {
    ignore_changes = [
      log,
      metric
    ]
  }
}
