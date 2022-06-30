/* 
-------------------------------------------------------------------------------------------
Name: 100-vm-template - main

Description:  Setup of a basic, stand alone virtual machine in Datacom Cloud FlexCompute
              based on a vApp template

Dependencies: Existing Org, VDC, Edge Gateway, Network and VM Template
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
  catalog_name  = var.template_catalog
  template_name = var.vm_template
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
}