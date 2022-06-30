/* 
-------------------------------------------------------------------------------------------
Name: 100-vm-basic - variables

Description:  Setup of a basic virtual machine in Datacom Cloud FlexCompute

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
variable "vm_os_type" {
  description = "Operating System type. Possible values can be found in the terraform provider documentation"
  default = "ubuntu64Guest"
}
variable "vm_hardware_version" {
  description = "Virtual Hardware Version (e.g.`vmx-14`, `vmx-13`, `vmx-12`, etc.)"
  default = "vmx-13"
}
variable "vm_os_disk_bus_type" {
  description = "The type of disk controller. Possible values: `ide`, `parallel`( LSI Logic Parallel SCSI), `sas`(LSI Logic SAS (SCSI)), `paravirtual`(Paravirtual (SCSI)), `sata`, `nvme`"
  default = "paravirtual"
}
variable "vm_os_disk_size" {
  description = "The size of the disk in MB"
  default = 40960
}