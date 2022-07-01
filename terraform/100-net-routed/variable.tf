/* 
-------------------------------------------------------------------------------------------
Name: 100-vm-template - variables

Description:  Setup of a basic virtual machine in Datacom Cloud FlexCompute
              based on a vApp template

Dependencies: Existing Org, VDC, Edge Gateway, Network and VM Template
-------------------------------------------------------------------------------------------
*/

# VMware Cloud Director Provider variables
variable "vcd_apiurl" {
  description = "URL for the Cloud Director API endpoint"
}
variable "vcd_user" {
  description = "Username for Cloud Director API operations"
}
variable "vcd_pass" {
  description = "Password for Cloud Director API operations"
}
variable "vcd_org" {
  description = "Cloud Director Org on which to run API operations"    
}
variable "vcd_vdc" {
  description = "Virtual datacenter within Cloud Director to run API operations against"
}

#Edge Gateway
variable "network_edge_gateway_name" {
  description = "Name for the edge gateway to which network is connected"
}

# Routed Network
variable "network_name" {
  description = "Unique name for the network"
}
variable "network_gateway" {
  description = "The gateway for this network (e.g. 192.168.1.1)"
}
variable "network_prefix_length" {
  description = "The prefix length for the new network (e.g. 24 for netmask 255.255.255.0)"
}
variable "network_static_ippool_start" {
  description = "The first address in the IP Range for Static IP Pool"
}
variable "network_static_ippool_end" {
  description = "The final address in the IP Range for Static IP Pool"
}