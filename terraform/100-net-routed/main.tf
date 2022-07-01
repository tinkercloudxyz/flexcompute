/* 
-------------------------------------------------------------------------------------------
Name: 100-net-routed - main

Description:  Setup of a routed network on an Edge Gateway in Datacom Cloud FlexCompute

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

# Import existing gateway
data "vcd_edgegateway" "edgegw" {
  org  = var.vcd_org
  vdc  = var.vcd_vdc
  name = var.network_edge_gateway
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