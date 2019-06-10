data "azuread_service_principal" "spn" {
  application_id = var.spn_client_id
}

data "azurerm_log_analytics_workspace" "loganalytics_workspace" {
  name                = var.workspace_id
  resource_group_name = var.workspace_rg
}
