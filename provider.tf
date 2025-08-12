terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.37.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "f70f869c-68fd-4dc8-9765-3a86206b0eb6"
}

resource "azurerm_resource_group" "rg1" {
  name     = "terraformrg111"
  location = "West Europe"
}
