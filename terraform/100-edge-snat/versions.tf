/* 
-------------------------------------------------------------------------------------------
Name: 100-edge-snat - providers
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