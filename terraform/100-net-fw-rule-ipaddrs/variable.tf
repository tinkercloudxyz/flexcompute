/* 
-------------------------------------------------------------------------------------------
Name: 100-net-fw-rule-ipaddrs - variables

Description:  Setup of a firewall rule with ip addresses on an Edge Gateway in 
              Datacom Cloud FlexCompute

Dependencies: Existing Org, VDC and Edge Gateway
-------------------------------------------------------------------------------------------
*/

# VMware Cloud Director Provider variables
variable "vcd_apiurl" {
  description = "URL for the Cloud Director API endpoint"
}
variable "vcd_user" {
  description = "Username for Cloud Director API operations"
}
variable "vcd_pass" {
  description = "Password for Cloud Director API operations"
}
variable "vcd_org" {
  description = "Cloud Director Org on which to run API operations"    
}
variable "vcd_vdc" {
  description = "Virtual datacenter within Cloud Director to run API operations against"
}

#Edge Gateway
variable "network_edge_gateway_name" {
  description = "Name for the edge gateway to which network is connected"
}

# Firewal Rule
variable "fw_rule_name" {
  description = "Name for the firewal rule"
}
variable "fw_rule_action" {
  description = "Defines if the rule is set to accept or deny traffic"
  default = "accept"
}
variable "fw_rule_src_ip_addrs" {
  description = "A set of source IP addresses, CIDRs or ranges. A keyword any is also accepted as a parameter"
}
variable "fw_rule_src_port" {
  description = "Source port number or range separated by - for port number"
  default = "any"
}
variable "fw_rule_dst_ip_addrs" {
  description = "A set of destination IP addresses, CIDRs or ranges. A keyword any is also accepted as a parameter"
}
variable "fw_rule_dst_port" {
  description = "Destination port number or range separated by - for port number"
}
variable "fw_rule_protocol" {
  description = "One of any, tcp, udp, icmp to apply"
}