#!/bin/bash
# If you meet any error in kolla-ansible deploy, after you fix the error,
# you can use this script to clean up the environment and deploy again.
set -e

source venv/bin/activate
cd venv/

kolla-ansible -i all-in-one --yes-i-really-really-mean-it destroy
kolla-ansible -i all-in-one deploy
