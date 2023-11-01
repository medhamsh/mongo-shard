variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  default     = "MongoDB-ResourceGroup"
}

variable "location" {
  description = "Azure region for the resources"
  default     = "East US"
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  default     = "MongoDB-VNet"
}

variable "vnet_address_space" {
  description = "Address space for the Virtual Network"
  default     = "10.0.0.0/16"
}

variable "subnet_name" {
  description = "Name of the Subnet"
  default     = "MongoDB-Subnet"
}

variable "subnet_address_prefix" {
  description = "Address prefix for the Subnet"
  default     = "10.0.1.0/24"
}

variable "nsg_name" {
  description = "Name of the Network Security Group"
  default     = "MongoDB-NSG"
}

variable "application_ip" {
  description = "CIDR notation for the application IP"
  default     = "your_application_ip/32" 
}

variable "management_ip" {
  description = "CIDR notation for the management IP"
  default     = "your_management_ip/32" 
}

