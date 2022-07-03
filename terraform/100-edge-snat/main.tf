/* 
-------------------------------------------------------------------------------------------
Name: 100-edge-snat - main

Description:  Setup of a Source NAT rule on an Edge Gateway in 
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