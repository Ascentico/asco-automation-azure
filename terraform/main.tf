# Global

variable "location_name" {}

variable "resource_group_name" {}

variable "nsg_name" {}
variable "allowed_ip" {}

variable "vnet_name" {}
variable "vnet_address_space" {}

variable "subnet_name" {}

# Storage Accounts

variable "terraform_storage_account_name" {}
variable "diag_storage_account_name" {}

# Tag Variables

variable "environment_name" {}
variable "owner_name" {}
variable "create_method" {}

# Admin Variables

variable "admin_username" {}
variable "admin_password" {}

# Jenkins Server Variables

variable "jenkins_server_name" {}
variable "jenkins_private_ip_address" {}
variable "jenkins_dns_label" {}
variable "jenkins_bootstrap_script" {}

# GitLab Server Variables

variable "gitlab_server_name" {}
variable "gitlab_private_ip_address" {}
variable "gitlab_dns_label" {}
variable "gitlab_bootstrap_script" {}

# Jenkins Windows Build Server Variables

variable "jenwin_server_name" {}
variable "jenwin_private_ip_address" {}
variable "jenwin_dns_label" {}
variable "jenwin_bootstrap_script" {}

# Windows

variable "windows_first_logon_command" {}

# Windows WinRM Script

variable "winrm_secure_port" {}
variable "winrm_bootstrap_script" {}

#Null resource to make the VM intermediate varable - probably not the right way to do this
resource "null_resource" "intermediates" {
  triggers = {
    full_vm_dns_name = "asco-jenwin.ukwest.cloudapp.azure.com"
  }
}

output "full_vm_dns_name" {
  value = "${null_resource.intermediates.triggers.full_vm_dns_name}"
}