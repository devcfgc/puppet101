#!/usr/bin/env bash
# This bootstraps Puppet on CentOS 7.x
# It has been tested on CentOS 7.0 64bit

set -e

# remove strange manually placed repo file
/bin/rm -f /etc/yum.repos.d/puppetlabs*

REPO_URL="http://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm"

if [ "$EUID" -ne "0" ]; then
  echo "######## This script must be run as root. ########" >&2
  exit 1
fi

if which puppet > /dev/null 2>&1; then
  echo "######## Puppet is already installed. ########"
  exit 0
fi

# Install wget
echo "######## Installing wget... ########"
yum install -y wget > /dev/null


# Install puppet labs repo
echo "######## Configuring PuppetLabs repo... ########"
repo_path=$(mktemp)
wget --output-document="${repo_path}" "${REPO_URL}" 2>/dev/null
rpm -i "${repo_path}" >/dev/null

# Install Puppet...
echo "######## Installing puppet && Start puppet services ########"
yum install -y puppetserver > /dev/null

ruby_version=2.3.0
echo "######## Installing Ruby ########"
gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://raw.githubusercontent.com/wayneeseguin/rvm/stable/binscripts/rvm-installer | sudo bash -s stable --ruby=${ruby_version} > /dev/null
source /usr/local/rvm/scripts/rvm

sed -i 's/-Xms2g/-Xms256m/g' /etc/sysconfig/puppetserver
sed -i 's/-Xmx2g/-Xmx256m/g' /etc/sysconfig/puppetserver

systemctl start puppetserver
systemctl start puppet

echo "######## Puppet installed! ########"
