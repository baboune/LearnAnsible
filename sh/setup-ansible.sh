#!/bin/bash

_install_dir=/root/install-ansible
mkdir -p ${_install_dir}

_epel_url="https://dl.fedoraproject.org/pub/epel/"

# Install epel 7
if [ ! -f ${_install_dir}/epel-release-latest-7.noarch.rpm ]; then
  curl -o ${_install_dir}/epel-release-latest-7.noarch.rpm ${_epel_url}/epel-release-latest-7.noarch.rpm
  yum install ${_install_dir}/epel-release-latest-7.noarch.rpm -y
fi

# Install ansible.
yum install ansible -y

# Preserve original config files
if [ ! -f /etc/ansible/ansible.cfg.save ]; then
  cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.save
fi
if [ ! -f /etc/ansible/hosts.save ]; then
  cp /etc/ansible/hosts /etc/ansible/hosts.save
fi

