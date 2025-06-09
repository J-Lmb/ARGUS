# App Service Plan and Function App (Docker)
variable "functionapp_docker_image" {
  description = "Docker image for the Function App."
  type        = string
  default     = "DOCKER|argus.azurecr.io/argus-backend:latest"
}

resource "azurerm_app_service_plan" "main" {
  name                = "${azurerm_resource_group.main.name}-plan"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "Linux"
  reserved            = true
  sku {
    tier = "Basic"
    size = "B1"
  }
  tags = {
    solution = "ARGUS-1.0"
  }
}

resource "azurerm_linux_function_app" "main" {
  name                       = "fa${random_string.unique.result}"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  service_plan_id            = azurerm_app_service_plan.main.id
  storage_account_name       = azurerm_storage_account.main.name
  storage_account_access_key = azurerm_storage_account.main.primary_access_key
  app_settings = {
    FUNCTIONS_WORKER_RUNTIME                = "python"
    FUNCTIONS_EXTENSION_VERSION             = "~4"
    WEBSITE_MAX_DYNAMIC_APPLICATION_SCALE_OUT = "1"
    FUNCTIONS_WORKER_PROCESS_COUNT          = "1"
    WEBSITES_ENABLE_APP_SERVICE_STORAGE     = "false"
    DOCKER_REGISTRY_SERVER_URL              = "https://index.docker.io"
    AzureWebJobsStorage__credential         = "managedidentity"
    AzureWebJobsStorage__serviceUri         = "https://${azurerm_storage_account.main.name}.blob.core.windows.net"
    AzureWebJobsStorage__blobServiceUri     = "https://${azurerm_storage_account.main.name}.blob.core.windows.net"
    AzureWebJobsStorage__queueServiceUri    = "https://${azurerm_storage_account.main.name}.queue.core.windows.net"
    AzureWebJobsStorage__tableServiceUri    = "https://${azurerm_storage_account.main.name}.table.core.windows.net"
    COSMOS_DB_ENDPOINT                     = azurerm_cosmosdb_account.main.endpoint
    COSMOS_DB_DATABASE_NAME                 = azurerm_cosmosdb_sql_database.main.name
    COSMOS_DB_CONTAINER_NAME                = azurerm_cosmosdb_sql_container.documents.name
    APPINSIGHTS_INSTRUMENTATIONKEY          = azurerm_application_insights.main.instrumentation_key
    # Add other settings as needed
  }
  site_config {
    linux_fx_version = var.functionapp_docker_image
    always_on        = true
    python_version   = "3.11"
  }
  identity {
    type = "SystemAssigned"
  }
  tags = {
    solution = "ARGUS-1.0"
  }
}
