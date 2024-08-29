#!/bin/bash
# This script is used to install openstack release 2023.1 on ubuntu22.04
set -e

ansible_version='ansible>=6,<8'
openstack_branch='stable/2023.1'
openstack_release='2023.1'
kolla_internal_vip_address='5.39.122.88'

python3 -m venv venv
source venv/bin/activate
cd venv/

pip install -U pip
pip install $ansible_version
pip install git+https://opendev.org/openstack/kolla-ansible@$openstack_branch

sudo mkdir -p /etc/kolla
sudo chown $USER:$USER /etc/kolla

cp -r share/kolla-ansible/etc_examples/kolla/* /etc/kolla
cp -r share/kolla-ansible/ansible/inventory/* .

kolla-ansible install-deps

kolla-genpwd
sed -i 's#keystone_admin_password:.*#keystone_admin_password: kolla#g' /etc/kolla/passwords.yml

cp -p /etc/kolla/globals.yml{,.bak}
grep -Ev '^$|^#' /etc/kolla/globals.yml.bak > /etc/kolla/globals.yml

cat >> /etc/kolla/globals.yml << EOF
kolla_base_distro: "ubuntu"
openstack_release: "$openstack_release"
kolla_internal_vip_address: "$kolla_internal_vip_address"
network_interface: "ens18"
neutron_external_interface: "ens19"
enable_cinder: "yes"
enable_cinder_backend_lvm: "yes"
enable_haproxy: "no"
EOF

kolla-ansible -i ./all-in-one bootstrap-servers
kolla-ansible -i ./all-in-one prechecks
kolla-ansible -i ./all-in-one deploy
