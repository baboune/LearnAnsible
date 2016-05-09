# LearnAnsible
Play around with Ansible and vagrant.

Launch vagrant, provisioning.

# Create sha password
$ pip install passlib
$ python -c "from passlib.hash import sha512_crypt; print sha512_crypt.encrypt('atomic')"
$6$rounds=656000$oopezXro4Wnys/EP$VoQbhD.dAb5HqedhTEBmqaGSOb9fNAtQUhIJHBeL8Jqv389znVP4iTOQ8QUjpvt9wrT8TPVwp.y8bt4vS86Ry/

# How to use

## Step 1: Create the user on the nodes for ansible install
$ vagrant ssh controller
$ sudo su  
$ ansible-playbook /vagrant/playbook/playbook.yml --ask-pass -u root
