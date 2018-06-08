#!/usr/bin/env bash

# Source controlled environment variables..."

# Global

export TF_VAR_location_name="UK West"

# Resource Tags

export TF_VAR_environment_name="Automation"
export TF_VAR_owner_name="ASCO"
export TF_VAR_create_method="Terraform"

# Resource Group

export TF_VAR_resource_group_name="ASCO-Automation-RG"

# Generate with uuidgen | awk '{print tolower($0)}'
export TF_VAR_terraform_storage_account_name="terraform97700f810ca3"
export TF_VAR_diag_storage_account_name="diag97700f810ca3"

# Network Security Group

export TF_VAR_nsg_name="ASCO-Automation-NSG"
#export TF_VAR_allowed_ip="82.71.62.199/32"
#export TF_VAR_allowed_ip="194.75.135.30/32"
export TF_VAR_allowed_ip="*"

# Virtual Network

export TF_VAR_vnet_name="ASCO-Automation-vNet"
export TF_VAR_vnet_address_space="10.0.0.0/24"

# Subnet

export TF_VAR_subnet_name="ASCO-Automation-Subnet"

# Jenkins

export TF_VAR_jenkins_server_name="asco-jen01"
export TF_VAR_jenkins_private_ip_address="10.0.0.5"
export TF_VAR_jenkins_dns_label="asco-jenkins"
export TF_VAR_jenkins_bootstrap_script="bootstrap-jenkins.sh"

# GitLab

export TF_VAR_gitlab_server_name="asco-git01"
export TF_VAR_gitlab_private_ip_address="10.0.0.6"
export TF_VAR_gitlab_dns_label="asco-gitlab"
export TF_VAR_gitlab_bootstrap_script="bootstrap-gitlab.sh"

# Jenkins Windows Build Server

export TF_VAR_jenwin_server_name="asco-jenwin01"
export TF_VAR_jenwin_private_ip_address="10.0.0.9"
export TF_VAR_jenwin_dns_label="asco-jenwin"
export TF_VAR_jenwin_bootstrap_script="bootstrap-jenwin.ps1"

# Windows

export TF_VAR_windows_first_logon_command="FirstLogonCommand.xml"

# Windows WinRM Script

export TF_VAR_winrm_bootstrap_script="bootstrap-winrm.ps1"
export TF_VAR_winrm_secure_port=5986