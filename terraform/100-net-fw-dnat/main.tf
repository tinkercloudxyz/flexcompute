/* 
-------------------------------------------------------------------------------------------
Name: 100-net-fw-dnat - main

Description:  Setup of a firewall destination NAT for internal (on an Edge Gateway in 
              Datacom Cloud FlexCompute

Dependencies: Existing Org, VDC and Edge Gateway
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

# Destination NAT on Edge Gateway
resource "vcd_nsxv_dnat" "dnat_1" {
  edge_gateway = var.network_edge_gateway_name
  network_type = var.network_type
  network_name = var.network_name
  enabled = var.dnat_enabled
  description  = var.dnat_description
  logging_enabled = var.dnat_logging

  original_address = var.dnat_orig_addr
  original_port    = var.dnat_orig_port

  translated_address = var.dnat_trans_addr
  translated_port    = var.dnat_trans_port
  protocol           = var.dnat_protocol
}
