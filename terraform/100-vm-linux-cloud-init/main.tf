/* 
-------------------------------------------------------------------------------------------
Name: 100-vm-linux-cloud-init - main

Description:  Setup of a stand alone linux virtual machine in Datacom Cloud FlexCompute
              based on a vApp template and customised using cloud-init

Dependencies: Existing Org, VDC, Edge Gateway, Network and VM Template
-------------------------------------------------------------------------------------------
*/

/* # Local admin password
provider "htpasswd" {
}
resource "random_password" "salt" {
  length = 8
}
resource "htpasswd_password" "hash" {
  password = var.vm_localadmin_passwd
  salt     = random_password.salt.result
} */

# VM based on specified VM template
resource "vcd_vm" "vm" {
  name          = var.vm_name
  catalog_name  = var.template_catalog
  template_name = var.vm_template
  power_on      = "true"
  memory        = var.vm_memory
  cpus          = var.vm_cpus
  cpu_cores     = var.vm_cpucores

  network {
    type               = var.vm_network_type
    name               = var.vm_network_name
    ip_allocation_mode = var.vm_ip_allocation_mode
    ip                 = var.vm_ip
  }

  guest_properties = {
    # "user-data" = base64encode(templatefile("cloud-config.yaml", { hostname = var.vm_name, localadmin = var.vm_localadmin_username, passwd = htpasswd_password.hash.sha512 }))
    # "user-data" = base64encode(templatefile("cloud-config.yaml", { hostname = var.vm_name, localadmin = var.vm_localadmin_username, sshauthorizedkey = var.vm_ssh_authorized_key }))
    "user-data" = base64encode(templatefile("cloud-config.yaml", { hostname = var.vm_name }))
  }
}