#!/bin/bash

echo "Overriding ansible configuration files and hosts"
cp /vagrant/cfg/etc/ansible/hosts /etc/ansible/
cp /vagrant/cfg/etc/ansible/ansible.cfg /etc/ansible/
