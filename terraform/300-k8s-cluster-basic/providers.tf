/* 
-------------------------------------------------------------------------------------------
Name: 300-k8s-cluster-basic - providers
-------------------------------------------------------------------------------------------
*/

terraform {
  # minimum version for Terraform
  required_version = ">= 1.2.1"
  required_providers {
    #provider: VMware Cloud Director - https://registry.terraform.io/providers/vmware/vcd/3.6.0
    vcd = {
      source  = "vmware/vcd"
      version = ">= 3.6.0"
    }
  }
}

# Connection to VDC within Org hosted at VMware Cloud Director URL
provider "vcd" {
  url      = var.vcd_apiurl
  user     = var.vcd_user
  password = var.vcd_pass
  org      = var.vcd_org
  vdc      = var.vcd_vdc
}