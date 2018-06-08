#!/usr/bin/env bash

# If we are not running as root then exit
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

# Update the system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install GitLab
## Install Dependencies
sudo apt-get install -y curl openssh-server ca-certificates
sudo echo "postfix postfix/mailname string gitlab.ascentico.com" | debconf-set-selections
sudo echo "postfix postfix/main_mailer_type string 'Internet Site'" | debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get install -y postfix
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
sudo EXTERNAL_URL="http://asco-gitlab.ukwest.cloudapp.azure.com" apt-get install gitlab-ce -y

# Install Chef Client
sudo wget https://packages.chef.io/files/stable/chef/14.1.12/ubuntu/18.04/chef_14.1.12-1_amd64.deb
sudo sudo dpkg -i chef_14.1.12-1_amd64.deb
sudo apt-get install -f

# Install Puppet
#sudo wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
#sudo sudo dpkg -i puppetlabs-release-trusty.deb
#sudo apt-get install puppet -y

# Install Git
sudo apt-get install git -y