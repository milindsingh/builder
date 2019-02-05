#!/usr/bin/env bash

# Install common development softwares:
# SSH
# Git
# Curl

USER=$(whoami)

export PATH=$PATH:/opt/lampp/bin

BUILDER_BASE_DIR=$(pwd)
BUILDER_TMP_PATH="${BASE_DIR}/tmp/"

##http://ubuntuhandbook.org/index.php/2016/04/enable-ssh-ubuntu-16-04-lts/
echo -e "\e[94m Installing SSH......\e[39m"
echo ""
sudo apt install openssh-server -y --force-yes
echo ""
echo -e "\e[32m Installed SSH Successfully.\e[39m"
echo ""

echo -e "\e[94m Installing Git......\e[39m"
echo ""
sudo apt install git -y --force-yes
echo ""
echo -e "\e[32m Installed Git Successfully.\e[39m"
echo ""

echo -e "\e[94m Installing Curl......\e[39m"
echo ""
sudo apt install curl -y --force-yes

echo ""
echo -e "\e[32m Installed Git Successfully.\e[39m"
echo ""

