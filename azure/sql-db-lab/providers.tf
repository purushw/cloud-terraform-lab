terraform {
  required_version = ">= 1.6.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.45.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "e500e191-c8d6-4d86-89a1-784371ce8ce1"
}

