output "config_server_ips" {
  value = azurerm_virtual_machine.config_server.*.private_ip_address
}

output "shard_server_ips" {
  value = azurerm_virtual_machine.shard_server.*.private_ip_address
}

output "mongos_server_ips" {
  value = azurerm_virtual_machine.mongos_server.*.private_ip_address
}

