/* 
-------------------------------------------------------------------------------------------
Name: 100-edge-dnat - main

Description:  Setup of a Destination NAT rule on an Edge Gateway in 
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
