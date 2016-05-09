#!/bin/bash
function f_check_is_root {
  if [ "$EUID" -ne 0 ]
    then echo "Please run as root"
    exit
  fi
}

# Debug
#set -eux

f_check_is_root

ANSIBLE_DIR=/etc/ansible

echo "This emulates the expected behavior of the Ansible controller"
echo "Overriding ansible configuration files and hosts to synced /vagrant"

# Remove files and replace with links
_file_list=( hosts ansible.cfg )
for l in "${_file_list[@]}"
do  
  if [ -f ${ANSIBLE_DIR}/${l} ]; then         
    echo "Removing file: ${ANSIBLE_DIR}/${l}"
    rm -f ${ANSIBLE_DIR}/${l}
  fi
done 

# Setup links
_link_list=( hosts ansible.cfg group_vars host_vars )

for l in "${_link_list[@]}"
do  
  if [ ! -L ${ANSIBLE_DIR}/${l} ]; then         
    echo "Adding link: ${ANSIBLE_DIR}/${l}"
    ln -s /vagrant/cfg/etc/ansible/${l} ${ANSIBLE_DIR}/${l}
  fi
done 
