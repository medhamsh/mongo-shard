# Config Servers
resource "azurerm_virtual_machine" "config_server" {
  count                = 3
  name                 = "MongoConfig${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  vm_size              = var.vm_size


  storage_os_disk {
    name              = "MongoConfigDisk${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = var.storage_size
  }

  network_interface_ids = [azurerm_network_interface.config_nic[count.index].id]

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "config${count.index}"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = var.boot_diagnostics_storage_uri
  }

  

}

# Shard Servers
resource "azurerm_virtual_machine" "shard_server" {
  count                = 4
  name                 = "MongoShard${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  vm_size              = var.vm_size

  
  storage_os_disk {
    name              = "MongoShardDisk${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = var.storage_size
  }

  resource "azurerm_network_interface" "shard_nic" {
  count               = 4
  name                = "nic-shard${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "shard_server" {
  count                = 4
  name                 = "MongoShard${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  vm_size              = var.vm_size
  network_interface_ids = [azurerm_network_interface.shard_nic[count.index].id]

  storage_os_disk {
    name              = "MongoShardDisk${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = var.storage_size
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "shard${count.index + 1}"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = var.boot_diagnostics_storage_uri
  }
}

}

# Mongos Servers
resource "azurerm_virtual_machine" "mongos_server" {
  count                = 2
  name                 = "MongoRouter${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  vm_size              = var.vm_size


  storage_os_disk {
    name              = "MongoRouterDisk${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = var.storage_size
  }

  resource "azurerm_network_interface" "mongos_nic" {
  count               = 2
  name                = "nic-mongos${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "mongos_server" {
  count                = 2
  name                 = "MongoRouter${count.index + 1}"
  location             = var.location
  resource_group_name  = var.resource_group_name
  vm_size              = var.vm_size
  network_interface_ids = [azurerm_network_interface.mongos_nic[count.index].id]

  storage_os_disk {
    name              = "MongoRouterDisk${count.index + 1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = var.storage_size
  }

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "20.04-LTS"
    version   = "latest"
  }

  os_profile {
    computer_name  = "router${count.index + 1}"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = var.boot_diagnostics_storage_uri
  }
}
}

