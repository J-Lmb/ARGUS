# Example variables file for ARGUS Terraform deployment
location             = "swedencentral"
resource_group_name  = "argus-rg"
azure_principal_id   = "743bf844-1b8d-4d6e-a512-693e27390630"
functionapp_docker_image = "DOCKER|argus.azurecr.io/argus-backend:latest"

# Azure AI resource configuration parameters
azure_openai_endpoint              = "<your-azure-openai-endpoint>"
azure_openai_key                   = "<your-azure-openai-key>"
azure_openai_model_deployment_name = "<your-azure-openai-model-deployment-name>"
document_intelligence_name         = "<your-document-intelligence-resource-name>"
# Add other variables as needed for additional Azure AI services
# For example, if you use more keys or endpoints, add them here
# Example:
# another_ai_service_endpoint = "<your-endpoint>"
# another_ai_service_key      = "<your-key>"
