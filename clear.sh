#!/bin/bash
# This script is used to clean up environment
set -e

rm -rf venv/
sudo rm -rf /etc/kolla/
sudo rm -rf /var/log/kolla/

containers=$(docker ps -aq)
if [ -n "$containers" ]; then
  docker rm -f $containers
fi

images=$(docker images -q)
if [ -n "$images" ]; then
  docker rmi $images
fi
