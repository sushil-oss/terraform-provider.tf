terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.38.1"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "4f66054f-49b5-4a50-97d4-b19124d09600"
}
# Configuration options


resource "azurerm_resource_group" "rg1" {
  name     = "SushilRG"
  location = "West Europe"
}

resource "azurerm_storage_account" "stg1" {
  name                     = "sushilstg1"
  resource_group_name      = azurerm_resource_group.rg1.name
  location                 = azurerm_resource_group.rg1.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}
resource "azurerm_storage_container" "stgcontainer" {
  name                  = "storagecontainer11"
  storage_account_id    = azurerm_storage_account.stg1.id
  container_access_type = "private"
}

resource "azurerm_storage_blob" "stgblob1" {
  name                   = "sushilblob1.zip"
  storage_account_name   = azurerm_storage_account.stg1.name
  storage_container_name = azurerm_storage_container.stgcontainer.name
  type                   = "Block"
  #source                 = "some-local-file.zip"
}

resource "azurerm_network_security_group" "nsg1" {
  name                = "sushilnsg11"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
}

resource "azurerm_virtual_network" "vn1" {
  name                = "sushilvn1"
  location            = azurerm_resource_group.rg1.location
  resource_group_name = azurerm_resource_group.rg1.name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name             = "subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.nsg1.id
  }

}

