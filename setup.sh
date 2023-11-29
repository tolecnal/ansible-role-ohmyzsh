#!/bin/sh

echo "Setting up ohmyzsh by tolecnal..."
echo ""

echo "Setting up requirements"
sudo apt-get install python3-pip
pip3 install ansible

echo "Making directory"
mkdir -p "${HOME}/tolecnal.ohmyzsh"

echo "Creating default inventory file"
cat << EOF > "${HOME}/tolecnal.ohmyzsh/inventory.yml"
[local]
localhost
EOF

echo "Creating default playbook file"
cat << EOF > "${HOME}/tolecnal.ohmyzsh/playbook.yml"
---

- name: Run tolecnal.ohmyzsh role
  hosts: all
  become: true
  gather_facts: true

  vars:
    ohmyzsh_users: tolecnal

  roles:
    - tolecnal.ohmyzsh
EOF

cd "${HOME}/tolecnal.ohmyzsh" || exit
ansible-galaxy role install tolecnal.ohmyzsh

printf "\nNow use:\n\tcd %s/tolecnal.ohmyzsh\n\tEdit playbook and change the user\n\tansible-playbook -i inventory.yml playbook.yml" "$HOME"
