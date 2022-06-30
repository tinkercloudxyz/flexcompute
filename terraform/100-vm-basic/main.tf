/* 
-------------------------------------------------------------------------------------------
Name: 100-vm-basic - main

Description:  Setup of a basic, stand alone virtual machine in Datacom Cloud FlexCompute

Dependencies: Existing Org, VDC, Edge Gateway, Network
-------------------------------------------------------------------------------------------
*/

# Connection to VDC within Org hosted at VMware Cloud Director URL
provider "vcd" {
  url      = var.vcd_apiurl
  user     = var.vcd_user
  password = var.vcd_pass
  org      = var.vcd_org
  vdc      = var.vcd_vdc
}

# VM based on specified VM template
resource "vcd_vm" "vm" {
  name          = var.vm_name
  power_on      = "true"
  memory        = var.vm_memory
  cpus          = var.vm_cpus
  cpu_cores     = var.vm_cpucores
  network {
    type               = var.vm_network_type
    name               = var.vm_network_name
    ip_allocation_mode = var.vm_ip_allocation_mode
    ip                 = var.vm_ip
  }
  os_type          = "ubuntu64Guest"
  hardware_version = "vmx-14"
}

resource "vcd_vm_internal_disk" "osdisk" {
  vm_name = var.vm_name
  bus_type = "paravirtual"
  size_in_mb = 40960
  bus_number = 0
  unit_number = 1
  allow_vm_reboot = true
  depends_on      = ["vcd_vm.vm"]
}