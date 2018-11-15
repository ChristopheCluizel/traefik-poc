#!/usr/bin/env bash

echo "==== Update the system"
sudo yum -y check-update
sudo yum -y update

echo "==== Install Docker and Docker-compose"
sudo yum -y install docker
sudo /etc/init.d/docker start
pip install docker-compose --user
sudo usermod -aG docker "$USER"