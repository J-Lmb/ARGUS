# Outputs for key resources
output "resource_group_name" {
  value = azurerm_resource_group.main.name
}

output "function_app_endpoint" {
  value = azurerm_linux_function_app.main.default_hostname
}

output "function_app_name" {
  value = azurerm_linux_function_app.main.name
}

output "storage_account_name" {
  value = azurerm_storage_account.main.name
}

output "container_name" {
  value = azurerm_storage_container.datasets.name
}

output "storage_account_key" {
  value = azurerm_storage_account.main.primary_access_key
}

output "blob_account_url" {
  value = azurerm_storage_account.main.primary_blob_endpoint
}

output "cosmos_url" {
  value = azurerm_cosmosdb_account.main.endpoint
}

output "cosmos_db_name" {
  value = azurerm_cosmosdb_sql_database.main.name
}

output "cosmos_documents_container_name" {
  value = azurerm_cosmosdb_sql_container.documents.name
}

output "cosmos_config_container_name" {
  value = azurerm_cosmosdb_sql_container.configuration.name
}
