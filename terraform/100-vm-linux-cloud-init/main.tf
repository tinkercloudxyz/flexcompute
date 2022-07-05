/* 
-------------------------------------------------------------------------------------------
Name: 100-vm-linux-cloud-init - main

Description:  Setup of a stand alone linux virtual machine in Datacom Cloud FlexCompute
              based on a vApp template and customised using cloud-init

Dependencies: Existing Org, VDC, Edge Gateway, Network and VM Template
-------------------------------------------------------------------------------------------
*/

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