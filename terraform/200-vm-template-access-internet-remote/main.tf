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

# Routed network on Edge Gateway
resource "vcd_network_routed_v2" "net_routed" {
  name            = var.network_name
  interface_type  = "internal"
  edge_gateway_id = data.vcd_edgegateway.edgegw.id
  gateway         = var.network_gateway
  prefix_length   = var.network_prefix_length

  static_ip_pool {
    start_address = var.network_static_ippool_start
    end_address   = var.network_static_ippool_end
  }
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

# Source NAT on Edge Gateway
resource "vcd_nsxv_snat" "snat_1" {
  edge_gateway = var.network_edge_gateway_name
  network_type = var.snat_outgoing_net_type
  network_name = var.snat_outgoing_net_name
  enabled = var.snat_enabled
  description  = var.snat_description
  logging_enabled = var.snat_logging

  original_address = var.snat_orig_addr
  translated_address = var.snat_trans_addr
}

# Firewall rule on Edge Gateway
resource "vcd_nsxv_firewall_rule" "fw_rule_1" {
  org          = var.vcd_org
  vdc          = var.vcd_vdc
  edge_gateway = var.network_edge_gateway_name
  name         = var.fw_rule_name

  action = var.fw_rule_action
  source {
    ip_addresses = [var.fw_rule_src_ip_addrs]
  }
  destination {
    ip_addresses = [var.fw_rule_dst_ip_addrs]
  }
  service {
    protocol    = var.fw_rule_protocol
    source_port = var.fw_rule_src_port
    port        = var.fw_rule_dst_port
  }
}

# Destination NAT on Edge Gateway
resource "vcd_nsxv_dnat" "dnat_1" {
  edge_gateway = var.network_edge_gateway_name
  network_type = var.dnat_incoming_net_type
  network_name = var.dnat_incoming_net_name
  enabled = var.dnat_enabled
  description  = var.dnat_description
  logging_enabled = var.dnat_logging

  original_address = var.dnat_orig_addr
  original_port    = var.dnat_orig_port

  translated_address = var.dnat_trans_addr
  translated_port    = var.dnat_trans_port
  protocol           = var.dnat_protocol
}

# Firewall rule on Edge Gateway
resource "vcd_nsxv_firewall_rule" "fw_rule_1" {
  org          = var.vcd_org
  vdc          = var.vcd_vdc
  edge_gateway = var.network_edge_gateway_name
  name         = var.fw_rule_name

  action = var.fw_rule_action
  source {
    ip_addresses = [var.fw_rule_src_ip_addrs]
  }
  destination {
    ip_addresses = [var.fw_rule_dst_ip_addrs]
  }
  service {
    protocol    = var.fw_rule_protocol
    source_port = var.fw_rule_src_port
    port        = var.fw_rule_dst_port
  }
}