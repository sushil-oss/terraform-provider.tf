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
  subscription_id = "def6c89e-a855-4b2a-a2d3-a1bc15337302"
}

resource "azurerm_resource_group" "rg1" {
  name     = "terraformrg1"
  location = "West Europe"
}
