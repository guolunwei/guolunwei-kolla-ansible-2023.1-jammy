#!/bin/bash
# This script is used to run post-deploy
# make sure to run it only once when the installation is complete
set -e

source venv/bin/activate
cd venv/

pip install python-openstackclient -c https://releases.openstack.org/constraints/upper/2023.1
kolla-ansible post-deploy

mkdir -p ~/.config/openstack
cp /etc/kolla/clouds.yaml ~/.config/openstack

venv/share/kolla-ansible/init-runonce > runonce.log
