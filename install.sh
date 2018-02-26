#!/bin/bash
# We run as root

set -e

while sudo fuser /var/{lib/{dpkg,apt/lists},cache/apt/archives}/lock >/dev/null 2>&1; do
  echo "waiting for apt lock"
  sleep 1
done

apt-get update
apt-get upgrade -y

apt-get install apt-transport-https ca-certificates curl software-properties-common

sudo apt-key add /tmp/docker.gpg
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update
apt-get install -y docker-ce

# Install UNMS
bash /tmp/unms_install.sh
