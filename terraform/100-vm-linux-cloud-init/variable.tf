/* 
-------------------------------------------------------------------------------------------
Name: 100-vm-linux-cloud-init - variables

Description:  Setup of a stand alone linux virtual machine in Datacom Cloud FlexCompute
              based on a vApp template and customised using cloud-init

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

# Virtual Machine variables
variable "vm_name" {
  description = "VM name"
}
variable "vm_vm_localadmin_passwd" {
  description = "Password to set for the local admin account for the VM"
  sensitive   = true
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
variable "vm_network_type" {
  description = "Network type, one of: `none`, `vapp` or `org`"
  default = "org"
}
variable "vm_network_name" {
  description = "Name of the network this VM should connect to"
}
variable "vm_ip_allocation_mode" {
  description = "IP address allocation mode. One of `POOL`, `DHCP`, `MANUAL`, `NONE`"
  default = "POOL"
}
variable "vm_ip" {
  description = "Should be empty string for `POOL`, `DHCP` and NONE. For `MANUAL`, Value must be valid IP address from a subnet defined in `static pool` for network"
  default = ""
}