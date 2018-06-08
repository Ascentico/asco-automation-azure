#!/usr/bin/env bash

# If we are not running as root then exit
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run as root" 1>&2
	exit 1
fi

# Update the system
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Java
sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -y
sudo echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
sudo DEBIAN_FRONTEND=noninteractive apt-get install oracle-java8-installer -y
## Make sure Java 8 becomes default java
apt-get install -y oracle-java8-set-default

# Install Jenkins
## Before install is necessary to add Jenkins to trusted keys and source list
wget -q -O - http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
sudo apt-get install jenkins -y

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