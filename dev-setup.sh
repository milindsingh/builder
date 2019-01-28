#!/usr/bin/env bash

#/etc/environment
export PATH=$PATH:/opt/lampp/bin
#USER=$(whoami)

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

echo -e "\e[94m Installing Composer......\e[39m"

DIRECTORY="/home/${USER}/.composer"
if [ ! -d "$DIRECTORY" ]; then
    sudo chmod 777 -R "/home/$USER/.composer"
fi

echo ""
sudo curl -s https://getcomposer.org/installer | /opt/lampp/bin/php
echo ""

PHP_PATH="/usr/local/bin/php"
if [ ! -f "$PHP_PATH" ]; then
	sudo ln -s /opt/lampp/bin/php /usr/local/bin/php
fi

echo -e "\e[32m Installed Composer Successfully.\e[39m"
echo ""

echo -e "\e[32m Setting CLI shortcuts.\e[39m"
echo "alias php='sudo /opt/lampp/bin/php'"  >> ".bashrc"
echo "alias phpcs='sudo /opt/lampp/bin/phpcs'"  >> ".bashrc"
echo "alias phpcpd='sudo /opt/lampp/bin/phpcpd'"  >> ".bashrc"

