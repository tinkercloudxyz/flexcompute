/* 
-------------------------------------------------------------------------------------------
Name: 100-edge-fw-ipaddrs - main

Description:  Setup of a firewall rule with ip addresses on an Edge Gateway in 
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

# Import existing gateway
data "vcd_edgegateway" "edgegw" {
  org  = var.vcd_org
  vdc  = var.vcd_vdc
  name = var.network_edge_gateway_name
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