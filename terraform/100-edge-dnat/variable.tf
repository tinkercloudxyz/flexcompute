/* 
-------------------------------------------------------------------------------------------
Name: 100-edge-dnat  - variables

Description:  Setup of a Destination NAT rule on an Edge Gateway in 
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

# Destination NAT details
variable "dnat_incoming_net_name" {
  description = "Incoming network name on which to apply the DNAT rule"
}
variable "dnat_incoming_net_type" {
  description = "Type of the network on which to apply the DNAT rule. Possible values org (for internal) or ext (for external)."
}
variable "dnat_enabled" {
  description = "Defines if the rule is enabled"
  default = "true"
}
variable "dnat_description" {
  description = "Description for DNAT rule"
}
variable "dnat_logging" {
  description = "Defines if the logging for this rule is enabled"
  default = "false"
}
variable "dnat_orig_addr" {
  description = "Original destination IP address, range or subnet. In the packet being inspected, this IP address or range would be those that appear as the destination IP address of the packet. These packet destination addresses are the ones translated by this DNAT rule."
}
variable "dnat_orig_port" {
  description = "Original destination port or port range. In the packet being inspected, this port or port range would be those that appear as the destination port of the packet. These packet destination ports are the ones translated by this DNAT rule."
}
variable "dnat_trans_addr" {
  description = "Translated IP address, range or subnet. IP addresses to which destination addresses on inbound packets will be translated. These addresses are the IP addresses of the one or more virtual machines for which you are configuring DNAT so that they can receive traffic from the external network."
}
variable "dnat_trans_port" {
  description = "Select the port or port range that inbound traffic is connecting to on the virtual machines on the internal network. These ports are the ones into which the DNAT rule is translating for the packets inbound to the virtual machines."
}
variable "dnat_protocol" {
  description = "Select the protocol to which the rule applies. One of tcp, udp, icmp, any"
  default = "any"
}