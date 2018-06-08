#!/usr/bin/env bash

echo "Using the following environment variables"

echo "   Source controlled environment variables..."

# Source controlled environment variables..."

# Global

echo "      TF_VAR_location_name=$TF_VAR_location_name"

# Resource Tags

echo "      TF_VAR_environment_name=$TF_VAR_environment_name"
echo "      TF_VAR_owner_name=$TF_VAR_owner_name"
echo "      TF_VAR_create_method=$TF_VAR_create_method"

# Resource Group

echo "      TF_VAR_resource_group_name=$TF_VAR_resource_group_name"

# Network Security Group

echo "      TF_VAR_nsg_name=$TF_VAR_nsg_name"
echo "      TF_VAR_allowed_ip=$TF_VAR_allowed_ip"

# Virtual Network

echo "      TF_VAR_vnet_name=$TF_VAR_vnet_name"
echo "      TF_VAR_vnet_address_space=$TF_VAR_vnet_address_space"

# Subnet

echo "      TF_VAR_subnet_name=$TF_VAR_subnet_name"

# Jenkins Details

echo "      TF_VAR_jenkins_server_name=$TF_VAR_jenkins_server_name"
echo "      TF_VAR_jenkins_private_ip_address=$TF_VAR_jenkins_private_ip_address"
echo "      TF_VAR_jenkins_dns_label=$TF_VAR_jenkins_dns_label"
echo "      TF_VAR_jenkins_bootstrap_script=$TF_VAR_jenkins_bootstrap_script"

# GitLab Details

echo "      TF_VAR_gitlab_server_name=$TF_VAR_gitlab_server_name"
echo "      TF_VAR_gitlab_private_ip_address=$TF_VAR_gitlab_private_ip_address"
echo "      TF_VAR_gitlab_dns_label=$TF_VAR_gitlab_dns_label"
echo "      TF_VAR_gitlab_bootstrap_script=$TF_VAR_gitlab_bootstrap_script"

# Jenkins Windows Build Server

echo "      TF_VAR_jenwin_server_name=$TF_VAR_jenwin_server_name"
echo "      TF_VAR_jenwin_private_ip_address=$TF_VAR_jenwin_private_ip_address"
echo "      TF_VAR_jenwin_dns_label=$TF_VAR_jenwin_dns_label"
echo "      TF_VAR_jenwin_bootstrap_script=$TF_VAR_jenwin_bootstrap_script"

# Windows

echo "      TF_VAR_windows_first_logon_command=$TF_VAR_windows_first_logon_command"

# WinRM

echo "      TF_VAR_winrm_bootstrap_script=$TF_VAR_winrm_bootstrap_script"
echo "      TF_VAR_winrm_secure_port=$TF_VAR_winrm_secure_port"

# Administrator Username and Password

echo "      TF_VAR_admin_username=$TF_VAR_admin_username"
echo "      TF_VAR_admin_password=***********"