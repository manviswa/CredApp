# =====================================================================
# Monitoring - Log Analytics workspace + Container Insights solution
# =====================================================================
# This module only owns the workspace + Container Insights solution.
# AKS ships its container logs/metrics here via its own oms_agent block
# (see modules/aks). Keeping the workspace standalone avoids a module
# cycle (AKS depends on this workspace, not the other way around).
# =====================================================================
resource "azurerm_log_analytics_workspace" "this" {
  name                = "log-${var.name_prefix}"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = var.retention_days
  tags                = var.tags
}

# Container Insights solution (surfaces AKS container metrics/logs).
resource "azurerm_log_analytics_solution" "container_insights" {
  solution_name         = "ContainerInsights"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.this.id
  workspace_name        = azurerm_log_analytics_workspace.this.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }

  tags = var.tags
}
