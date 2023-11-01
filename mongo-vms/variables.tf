variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default     = "MongoDB-ResourceGroup"
}

variable "location" {
  description = "Azure region for the resources"
  default     = "East US"
}

variable "vm_size" {
  description = "Size of the VMs"
  default     = "Standard_D4s_v4"
}

variable "storage_size" {
  description = "Size of the attached storage in GB"
  default     = 100
}

variable "subnet_id" {
  description = "ID of the subnet where VMs will be created"
}

variable "admin_username" {
  description = "Admin username for the VMs"
  default     = "mongoadmin"
}

variable "admin_password" {
  description = "Admin password for the VMs"
}

variable "boot_diagnostics_storage_uri" {
  description = "URI of the storage account for boot diagnostics"
}
