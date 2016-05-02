#!/bin/bash
echo "Run playbooks from controller"

ansible-playbook /vagrant/playbook/setup-users.yml --ask-pass -u root