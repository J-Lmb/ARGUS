# Application Insights and Log Analytics
resource "azurerm_log_analytics_workspace" "main" {
  name                = "logAnalyticsWorkspace-${random_string.unique.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  retention_in_days   = 30
  tags = {
    solution = "ARGUS-1.0"
  }
}

resource "azurerm_application_insights" "main" {
  name                = "app-insights-${random_string.unique.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  application_type    = "web"
  workspace_id        = azurerm_log_analytics_workspace.main.id
  tags = {
    solution = "ARGUS-1.0"
  }
}
