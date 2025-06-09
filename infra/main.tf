# Terraform configuration for ARGUS Azure deployment
# This file is the entry point for Terraform and will call individual modules/resources for each Azure service.

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Use a random string for unique resource naming (similar to uniqueString in Bicep)
resource "random_string" "unique" {
  length  = 6
  upper   = false
  special = false
}

# Variables for location and resource group
variable "location" {
  description = "Azure region to deploy resources in."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group."
  type        = string
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Include additional resources in separate files for clarity (storage, cosmosdb, app service, etc.)
# See storage.tf, cosmosdb.tf, functionapp.tf, etc.
