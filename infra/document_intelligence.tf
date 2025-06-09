# Document Intelligence (Azure AI Form Recognizer)
resource "azurerm_cognitive_account" "document_intelligence" {
  name                = "di${random_string.unique.result}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  kind                = "FormRecognizer"
  sku_name            = "S0"
  tags = {
    solution = "ARGUS-1.0"
  }
  properties = {}
  custom_subdomain_name = "di${random_string.unique.result}"
  public_network_access_enabled = true
}
