/*
provider "azurerm" {
  features {}
}
*/

resource "azurerm_storage_account" "storage_account" {

  name                              = var.name
  location                          = var.location
  resource_group_name               = var.storage_account_resource_group_name
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = var.storage_account_replication_type
  access_tier                       = var.storage_account_access_tier
  min_tls_version                   = "TLS1_2"
  is_hns_enabled                    = var.is_hns_enabled
  tags                              = var.tags
  public_network_access_enabled     = var.public_network_access_enabled
  cross_tenant_replication_enabled  = var.cross_tenant_replication_enabled
  allow_nested_items_to_be_public   = var.public_network_access_enabled


  dynamic "blob_properties" {
    for_each = var.retention_policy ? [{}] : []

    content {
      dynamic "delete_retention_policy" {
        for_each = var.retention_policy ? [{}] : []

        content {
          days = var.retention_days
        }

      }
      dynamic "container_delete_retention_policy" {
        for_each = var.retention_policy ? [{}] : []

        content {
          days = var.retention_days
        }
      }
    }

  }

  dynamic "static_website" {
    for_each = var.enable_static_website ? [{}] : []

    content {
      index_document     = var.index_path
      error_404_document = var.custom_404_path
    }
  }

  dynamic "network_rules" {
    for_each = var.use_databricks_subnets ? [{}] : []

    content {
      default_action = "Deny"
      bypass = ["AzureServices"]
      virtual_network_subnet_ids = [
          "/subscriptions/23a8c420-c354-43f9-91f5-59d08c6b3dff/resourceGroups/prod-centralus-snp-1-compute-2/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet",
          "/subscriptions/31ef391b-7908-48ec-8c74-e432113b607b/resourceGroups/prod-centralus-snp-1-compute-3/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet",
          "/subscriptions/653c13e3-a85b-449b-9d14-e3e9c4b0d391/resourceGroups/prod-centralus-snp-1-compute-6/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet",
          "/subscriptions/6c0d042c-6733-4420-a3cc-4175d0439b29/resourceGroups/prod-centralus-snp-1-compute-4/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet",
          "/subscriptions/8453a5d5-9e9e-40c7-87a4-0ab4cc197f48/resourceGroups/prod-azure-centralus-nephos10-xr/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet",
          "/subscriptions/8453a5d5-9e9e-40c7-87a4-0ab4cc197f48/resourceGroups/prod-azure-centralus-nephos9-xr/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet",
          "/subscriptions/8453a5d5-9e9e-40c7-87a4-0ab4cc197f48/resourceGroups/prod-centralus-snp-1-compute-1/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet",
          "/subscriptions/9d5fffc7-7640-44a1-ba2b-f77ada7731d4/resourceGroups/prod-centralus-snp-1-compute-5/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet",
          "/subscriptions/b4f59749-ad17-4573-95ef-cc4c63a45bdf/resourceGroups/prod-centralus-snp-1-compute-10/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet",
          "/subscriptions/d31d7397-093d-4cc4-abd6-28b426c0c882/resourceGroups/prod-centralus-snp-1-compute-9/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet",
          "/subscriptions/56beece1-dbc8-40ca-8520-e1d514fb2ccc/resourceGroups/prod-centralus-snp-1-compute-8/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet",
          "/subscriptions/b96a1dc5-559f-4249-a30c-5b5a98023c45/resourceGroups/prod-centralus-snp-1-compute-7/providers/Microsoft.Network/virtualNetworks/kaas-vnet/subnets/worker-subnet"
      ]
    }
  }

  lifecycle {
    ignore_changes = [
      tags["createdDate"],
      azure_files_authentication
    ]
  }
}
/*
resource "azurerm_management_lock" "storage_lock" {
  name       = "${var.name}_lock"
  scope      = azurerm_storage_account.storage_account.id
  lock_level = "CanNotDelete"
  notes      = "Locked to prevent deletion"
}
*/
