/* 
-------------------------------------------------------------------------------------------
Module: 300-k8s-cluster-basic - variable

Description:  Setup of a basic kubernetes cluster in Datacom Cloud FlexCompute
              made up of combined nodes (master & worker) and bastion with remote access

Dependencies: Existing Org, VDC, Edge Gateway, Network and VM Template
-------------------------------------------------------------------------------------------
*/

#Edge Gateway
variable "network_edge_gateway_name" {
  description = "Name of the edge gateway for the network to which the VM is connected"
}

#Catalogue
variable "template_catalog" {
  description = "Catalog name in which to find the given vApp Template"
}

# Bastion VM variables
variable "bastion_name" {
  description = "Name of the Bastion virtual machine (VM)"
}
variable "bastion_template" {
  description = "Name of the vApp Template to use for Bastion"
}
variable "bastion_admin_pwd" {
  description = "Local admin password for Bastion VM"
}
variable "bastion_memory" {
  description = "Amount of RAM (in MB) to allocate to the Bastion VM"
  default = 2048
}
variable "bastion_cpus" {
  description = "Number of virtual CPUs to allocate to the Bastion VM"
  default = 1
}
variable "bastion_network_name" {
  description = "Name of the network the Bastion VM should connect to"
}
variable "bastion_ip_allocation_mode" {
  description = "IP address allocation mode. One of `POOL`, `DHCP`, `MANUAL`, `NONE`"
  default = "POOL"
}
variable "bastion_remote_access_port" {
  description = "Port or port range to be used for remote access to Bastion VM"
}
variable "bastion_remote_access_protocol" {
  description = "Protocol used for remote access to Bastion VM. One of tcp, udp or any"
  default = "any"
}


# Node VM variables
variable "nodes_count" {
  description = "Number of node VMs for cluster"
}
variable "nodes_name_prefix" {
  description = "Prefix for names for the node VMs"
}
variable "nodes_template" {
  description = "Name of the vApp Template to use for the node VMs"
}
variable "nodes_admin_pwd" {
  description = "Local admin password for the node VMs"
}
variable "nodes_memory" {
  description = "Amount of RAM (in MB) to allocate to the the node VMs"
  default = 2048
}
variable "nodes_cpus" {
  description = "Number of virtual CPUs to allocate to the Bthe node VMs"
  default = 1
}
variable "nodes_network_name" {
  description = "Name of the network the the node VMs should connect to"
}
variable "nodes_ip_allocation_mode" {
  description = "IP address allocation mode. One of `POOL`, `DHCP`, `MANUAL`, `NONE`"
  default = "POOL"
}