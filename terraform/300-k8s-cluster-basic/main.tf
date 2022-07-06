/* 
-------------------------------------------------------------------------------------------
Name: 300-k8s-cluster-basic  - main

Description:  Setup of a basic kubernetes cluster in Datacom Cloud FlexCompute
              made up of combined nodes (master & worker) and bastion with remote access

Dependencies: Existing Org, VDC, Edge Gateway, Network and VM Template
-------------------------------------------------------------------------------------------
*/

# Import existing gateway
data "vcd_edgegateway" "edgegw" {
  org  = var.vcd_org
  vdc  = var.vcd_vdc
  name = var.network_edge_gateway_name
}

# Bastion node
module "bastion" {
  source = "./vm-bastion"
  # Edge Gateway
  network_edge_gateway_name           = data.vcd_edgegateway.edgegw.name
  network_edge_gateway_extnet_name    = tolist(data.vcd_edgegateway.edgegw.external_network)[0].name
  network_edge_gateway_extnet_ipaddr  = data.vcd_edgegateway.edgegw.default_external_network_ip

  # Virtual Machine variables
  vm_name                   = var.bastion_name
  template_catalog          = var.template_catalog
  vm_template               = var.bastion_template
  vm_admin_pwd              = var.bastion_admin_pwd
  vm_memory                 = var.bastion_memory
  vm_cpus                   = var.bastion_cpus
  vm_network_name           = var.bastion_network_name
  vm_ip_allocation_mode     = var.bastion_ip_alloc_mode
  vm_remote_access_port     = var.bastion_remote_access_port
  vm_remote_access_protocol = var.bastion_remote_access_protocol
}

# Kubernetes comnbined nodes
module "nodes" {
  source = "./vm-node"
  count                 = var.nodes_count

  # Edge Gateway
  network_edge_gateway_name           = data.vcd_edgegateway.edgegw.name
  network_edge_gateway_extnet_name    = tolist(data.vcd_edgegateway.edgegw.external_network)[0].name
  network_edge_gateway_extnet_ipaddr  = data.vcd_edgegateway.edgegw.default_external_network_ip

  # Virtual Machine variables
  vm_name                 = "${var.nodes_name_prefix}${count.index + 1}"
  vm_localadmin_username  = var.nodes_localadmin_username
  vm_ssh_authorized_key   = var.nodes_ssh_authorized_key
  template_catalog        = var.template_catalog
  vm_template             = var.nodes_template
  vm_memory               = var.nodes_memory
  vm_cpus                 = var.nodes_cpus
  vm_network_name         = var.nodes_network_name
  vm_ip_allocation_mode   = var.nodes_ip_alloc_mode
}