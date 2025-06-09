# Cosmos DB Account, Database, and Containers
resource "azurerm_cosmosdb_account" "main" {
  name                = "cb${random_string.unique.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  enable_automatic_failover = false
  consistency_policy {
    consistency_level = "Session"
  }
  geo_location {
    location          = azurerm_resource_group.main.location
    failover_priority = 0
  }
  capabilities {
    name = "EnableServerless"
  }
  tags = {
    solution = "ARGUS-1.0"
  }
}

resource "azurerm_cosmosdb_sql_database" "main" {
  name                = "doc-extracts"
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.main.name
}

resource "azurerm_cosmosdb_sql_container" "documents" {
  name                = "documents"
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.main.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/partitionKey"
  default_ttl         = -1
}

resource "azurerm_cosmosdb_sql_container" "configuration" {
  name                = "configuration"
  resource_group_name = azurerm_resource_group.main.name
  account_name        = azurerm_cosmosdb_account.main.name
  database_name       = azurerm_cosmosdb_sql_database.main.name
  partition_key_path  = "/partitionKey"
  default_ttl         = -1
}
