/* 
-------------------------------------------------------------------------------------------
Name: 200-vm-template-access-internet-remote - variables

Description:  Setup of a single virtual machine in Datacom Cloud FlexCompute
              based on a vApp template with outgoing internet access and incoming remote
              access

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
  description = "Name of the edge gateway for the network to which the VM is connected"
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
variable "vm_remote_access_port" {
  description = "Port or port range to be used for remote access to VM"
}
variable "vm_remote_access_protocol" {
  description = "Protocol used for remote access to VM. One of tcp, udp or any"
  default = "any"
}

# Outgoing Internet Access - Source NAT details
variable "snat_description" {
  description = "Description for SNAT rule"
}
variable "snat_logging" {
  description = "Defines if the logging for this rule is enabled"
  default = "false"
}
variable "snat_orig_addr" {
  description = "Original source IP address, range or subnet. These addresses are the IP addresses of one or more virtual machines for which you are configuring the SNAT rule so that they can send traffic to the external network."
}
variable "snat_trans_addr" {
  description = "Translated IP address, range or subnet. This address is always the external IP address of the gateway for which you are configuring the SNAT rule. Specifies the IP address to which source addresses (the virtual machines) on outbound packets are translated to when they send traffic to the external network."
}

# Outgoing Internet Access - Firewall Rule
variable "fw_internet_description" {
  description = "Description for the firewal rule"
}
variable "fw_internet_logging" {
  description = "Defines if the logging for this rule is enabled"
  default = "false"
}

# Incoming Remote Access - Destination NAT details
variable "dnat_description" {
  description = "Description for DNAT rule"
}
variable "dnat_logging" {
  description = "Defines if the logging for this rule is enabled"
  default = "false"
}

# Incoming Remote Access - Firewal Rule
variable "fw_remote_description" {
  description = "Description for the firewal rule"
}
variable "fw_remote_logging" {
  description = "Defines if the logging for this rule is enabled"
  default = "false"
}