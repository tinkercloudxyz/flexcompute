/* 
-------------------------------------------------------------------------------------------
Module: 300-k8s-cluster-basic - bastion - main

Description:  Module to setup bastion in Datacom Cloud FlexCompute
              based on a vApp template with outgoing internet access and remote access 

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
  
  guest_properties = {
    "user-data" = base64encode(templatefile("${path.module}/cloud-config.yaml", { hostname = var.vm_name, localadmin = var.vm_localadmin_username, sshauthorizedkey = var.vm_ssh_authorized_key, remotesshauthorizedkey = var.vm_remote_node_authorized_key }))
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

# Incoming Remote Access - Destination NAT
resource "vcd_nsxv_dnat" "dnat_1" {
  edge_gateway = var.network_edge_gateway_name
  network_type = "ext"
  network_name = var.network_edge_gateway_extnet_name
  description  = var.dnat_description != "" ?  var.dnat_description : "${var.vm_name} - Remote Access on ${var.vm_remote_access_port} to VM"
  logging_enabled = var.dnat_logging

  original_address = var.network_edge_gateway_extnet_ipaddr
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
    ip_addresses = [var.network_edge_gateway_extnet_ipaddr]
  }
  service {
    protocol    = var.vm_remote_access_protocol
    source_port = "any"
    port        = var.vm_remote_access_port
  }

  depends_on = [vcd_nsxv_dnat.dnat_1]
}

# temporary outputs
output "cloudinitfilecontents" {
  value = templatefile("${path.module}/cloud-config.yaml", { hostname = var.vm_name, localadmin = var.vm_localadmin_username, sshauthorizedkey = var.vm_ssh_authorized_key, remotesshauthorizedkey = var.vm_remote_node_authorized_key })
  sensitive = true
}