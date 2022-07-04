/* 
-------------------------------------------------------------------------------------------
Module: 300-k8s-cluster-basic - vm-node - main

Description:  Module to setup a kubernetes node in Datacom Cloud FlexCompute
              based on a vApp template with outgoing internet access 

Dependencies: Existing Org, VDC, Edge Gateway, Network and VM Template
-------------------------------------------------------------------------------------------
*/

# VM based on specified VM template
resource "vcd_vm" "vm" {
  name          = var.vm_name
  catalog_name  = var.template_catalog
  template_name = var.vm_template
  memory        = var.vm_memory
  cpus          = var.vm_cpus
  cpu_cores     = var.vm_cpucores
  network {
    type               = "org"
    name               = var.vm_network_name
    ip_allocation_mode = var.vm_ip_allocation_mode
    ip                 = var.vm_ip_manual
  }
  power_on      = "true"
  customization {
    enabled = "true"
    allow_local_admin_password = "true"
    auto_generate_password = "false"
    admin_password = var.vm_admin_pwd
  }
}

# Outgoing Internet Access - Source NAT
resource "vcd_nsxv_snat" "snat_1" {
  edge_gateway = var.network_edge_gateway_name
  network_type = "ext"
  network_name = var.network_edge_gateway_extnet_name
  description  = var.snat_description != "" ?  var.snat_description : "${var.vm_name} - VM to internet"  #Check if snat description is blank, if so create a descripion
  logging_enabled = var.snat_logging
  original_address = "${vcd_vm.vm.network[0].ip}"
  translated_address = var.network_edge_gateway_extnet_ipaddr

  depends_on = [vcd_vm.vm]
}

# Outgoing Internet Access - Firewall rule allow outgoing internet access for VM
resource "vcd_nsxv_firewall_rule" "fw_internet" {
  edge_gateway = var.network_edge_gateway_name
  name         = var.fw_internet_description != "" ? var.fw_internet_description : "${var.vm_name} - allow outgoing internet access " #Check if fw internet description is blank, if so create a descripion

  action = "accept"
  logging_enabled = var.fw_internet_logging
  source {
    ip_addresses = ["${vcd_vm.vm.network[0].ip}"]
  }
  destination {
    ip_addresses = ["any"]
  }
  service {
    protocol    = "any"
    source_port = "any"
    port        = "any"
  }

  depends_on = [vcd_nsxv_snat.snat_1]
}