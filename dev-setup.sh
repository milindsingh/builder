#!/usr/bin/env bash

#/etc/environment
export PATH=$PATH:/opt/lampp/bin

##http://ubuntuhandbook.org/index.php/2016/04/enable-ssh-ubuntu-16-04-lts/
echo -e "\e[94m Installing SSH......\e[39m"
echo ""
sudo apt install openssh-server -y
echo ""
echo -e "\e[32m Installed SSH Successfully.\e[39m"
echo ""

echo -e "\e[94m Installing Git......\e[39m"
echo ""
sudo apt install git -y
echo ""
echo -e "\e[32m Installed Git Successfully.\e[39m"
echo ""

echo -e "\e[94m Installing Curl......\e[39m"
echo ""
sudo apt install curl -y
echo ""
echo -e "\e[32m Installed Git Successfully.\e[39m"
echo ""

echo -e "\e[94m Installing Composer......\e[39m"
echo ""
sudo curl -s https://getcomposer.org/installer | /opt/lampp/bin/php
echo ""

if [-f !"/usr/local/bin/php"]
then
	sudo ln -s /opt/lampp/bin/php /usr/local/bin/php
fi

echo -e "\e[32m Installed Composer Successfully.\e[39m"
echo ""
