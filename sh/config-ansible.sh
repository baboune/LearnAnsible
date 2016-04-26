#!/bin/bash
function f_check_is_root {
  if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
  fi
}

f_check_is_root

ANSIBLE_DIR=/etc/ansible

echo "This emulates the expected behavior of the Ansible controller"
echo "Overriding ansible configuration files and hosts to synced /vagrant"

# Setup links
_link_list=( hosts ansible.cfg group_vars host_vars )

for l in "${_link_list[@]}"
do
  if [ ! -z ${ANSIBLE_DIR}/${l} ]; then         
    echo "Adding link: ${ANSIBLE_DIR}/${l}"
    ln -s /vagrant/cfg/etc/ansible/${l} ${ANSIBLE_DIR}/${l}
  fi
done 
