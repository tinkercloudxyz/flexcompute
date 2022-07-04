/* 
-------------------------------------------------------------------------------------------
Name: 200-vm-template-access-internet-remote - main

Description:  Setup of a single virtual machine in Datacom Cloud FlexCompute
              based on a vApp template with outgoing internet access and incoming remote
              access

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

# Import existing gateway
data "vcd_edgegateway" "edgegw" {
  org  = var.vcd_org
  vdc  = var.vcd_vdc
  name = var.network_edge_gateway_name
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
    type               = "org"
    name               = var.vm_network_name
    ip_allocation_mode = var.vm_ip_allocation_mode
    ip                 = var.vm_ip_manual
  }
}

# Outgoing Internet Access - Source NAT
resource "vcd_nsxv_snat" "snat_1" {
  edge_gateway = var.network_edge_gateway_name
  network_type = "ext"
  network_name = tolist(data.vcd_edgegateway.edgegw.external_network)[0].name
  description  = var.snat_description != "" ?  var.snat_description : "${var.vm_name} - VM to internet"  #Check if snat description is blank, if so create a descripion
  logging_enabled = var.snat_logging
  original_address = "${vcd_vm.vm.network[0].ip}"
  translated_address = "${data.vcd_edgegateway.edgegw.default_external_network_ip}"

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

# Incoming Remote Access - Destination NAT
resource "vcd_nsxv_dnat" "dnat_1" {
  edge_gateway = var.network_edge_gateway_name
  network_type = "ext"
  network_name = tolist(data.vcd_edgegateway.edgegw.external_network)[0].name
  description  = var.dnat_description != "" ?  var.dnat_description : "${var.vm_name} - Remote Access on ${var.vm_remote_access_port} to VM"
  logging_enabled = var.dnat_logging

  original_address = data.vcd_edgegateway.edgegw.default_external_network_ip
  original_port    = var.vm_remote_access_port

  translated_address = "${vcd_vm.vm.network[0].ip}"
  translated_port    = var.vm_remote_access_port
  protocol           = var.vm_remote_access_protocol

  depends_on = [vcd_vm.vm]
}

# Incoming Remote Access - Firewall rule allow incoming remote access to VM
resource "vcd_nsxv_firewall_rule" "fw_remote_access" {
  edge_gateway = var.network_edge_gateway_name
  name         = var.fw_remote_description != "" ? var.fw_remote_description : "${var.vm_name} - allow incoming remote access "

  action = "accept"
  logging_enabled = var.fw_remote_logging
  source {
    ip_addresses = ["any"]
  }
  destination {
    ip_addresses = ["${data.vcd_edgegateway.edgegw.default_external_network_ip}"]
  }
  service {
    protocol    = var.vm_remote_access_protocol
    source_port = "any"
    port        = var.vm_remote_access_port
  }

  depends_on = [vcd_nsxv_dnat.dnat_1]
}