/* 
-------------------------------------------------------------------------------------------
Name: 100-edge-snat  - variables

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

# Source NAT details
variable "snat_outgoing_net_name" {
  description = "Outgoing network name on which to apply the snat rule"
}
variable "snat_outgoing_net_type" {
  description = "Type of the network on which to apply the snat rule. Possible values org (for internal) or ext (for external)."
}
variable "snat_enabled" {
  description = "Defines if the rule is enabled"
  default = "true"
}
variable "snat_description" {
  description = "Description for SNAT rule"
}
variable "snat_logging" {
  description = "Defines if the logging for this rule is enabled"
  default = "false"
}
variable "snat_orig_addr" {
  description = "Original source IP address, range or subnet. These addresses are the IP addresses of one or more virtual machines for which you are configuring the SNAT rule so that they can send traffic to the external network."
}
variable "snat_trans_addr" {
  description = "Translated IP address, range or subnet. This address is always the external IP address of the gateway for which you are configuring the SNAT rule. Specifies the IP address to which source addresses (the virtual machines) on outbound packets are translated to when they send traffic to the external network."
}