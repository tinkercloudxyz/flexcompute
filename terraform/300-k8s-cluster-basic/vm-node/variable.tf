/* 
-------------------------------------------------------------------------------------------
Module: 300-k8s-cluster-basic - vm-node - variable

Description:  Module to setup a kubernetes node in Datacom Cloud FlexCompute
              based on a vApp template with outgoing internet access 

Dependencies: Existing Org, VDC, Edge Gateway, Network and VM Template
-------------------------------------------------------------------------------------------
*/

#Edge Gateway
variable "network_edge_gateway_name" {
  description = "Name of the edge gateway for the network to which the VM is connected"
}
variable "network_edge_gateway_extnet_name" {
  description = "Name of the edge gateway external network"
}
variable "network_edge_gateway_extnet_ipaddr" {
  description = "IP address of the edge gateway external network to be used"
}

# Virtual Machine variables
variable "vm_name" {
  description = "Name of the virtual machine (VM)"
}
variable "template_catalog" {
  description = "Catalog name in which to find the given vApp Template"
}
variable "vm_template" {
  description = "Name of the vApp Template to use"
}
variable "vm_admin_pwd" {
  description = "Local admin password for VM"
}
variable "vm_memory" {
  description = "Amount of RAM (in MB) to allocate to the VM"
  default = 2048
}
variable "vm_cpus" {
  description = "Number of virtual CPUs to allocate to the VM"
  default = 1
}
variable "vm_cpucores" {
  description = "Number of cores per socket / virtual CPU"
  default = 1
}
variable "vm_network_name" {
  description = "Name of the network this VM should connect to"
}
variable "vm_ip_allocation_mode" {
  description = "IP address allocation mode. One of `POOL`, `DHCP`, `MANUAL`, `NONE`"
  default = "POOL"
}
variable "vm_ip_manual" {
  description = "Should be empty string for `POOL`, `DHCP` and NONE. For `MANUAL`, Value must be valid IP address from a subnet defined in `static pool` for network"
  default = ""
}

# Outgoing Internet Access - Source NAT details
variable "snat_description" {
  description = "Description for SNAT rule"
  default = ""
}
variable "snat_logging" {
  description = "Defines if the logging for this rule is enabled"
  default = "false"
}

# Outgoing Internet Access - Firewall Rule
variable "fw_internet_description" {
  description = "Description for the firewal rule"
  default = ""
}
variable "fw_internet_logging" {
  description = "Defines if the logging for this rule is enabled"
  default = "false"
}