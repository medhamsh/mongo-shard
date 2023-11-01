provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "mongo_rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "mongo_vnet" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = azurerm_resource_group.mongo_rg.location
  resource_group_name = azurerm_resource_group.mongo_rg.name
}

resource "azurerm_subnet" "mongo_subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.mongo_rg.name
  virtual_network_name = azurerm_virtual_network.mongo_vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}

resource "azurerm_network_security_group" "mongo_nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.mongo_rg.location
  resource_group_name = azurerm_resource_group.mongo_rg.name

  security_rule {
    name                       = "MongoDB"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "27017"
    source_address_prefix      = var.application_ip
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = var.management_ip
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "mongo_nsg_association" {
  subnet_id                 = azurerm_subnet.mongo_subnet.id
  network_security_group_id = azurerm_network_security_group.mongo_nsg.id
}

