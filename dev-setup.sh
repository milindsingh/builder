#!/usr/bin/env bash

#/etc/environment
export PATH=$PATH:/opt/lampp/bin
USER=$(whoami)

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

cp ./composer.phar /usr/local/bin/composer

PHP_PATH="/usr/local/bin/php"
if [ ! -f "$PHP_PATH" ]; then
	sudo ln -s /opt/lampp/bin/php /usr/local/bin/php
fi

echo -e "\e[32m Installed Composer Successfully.\e[39m"
echo ""

echo "Adding symlinks........"
sudo ln -s /opt/lampp/bin/php /usr/bin/php
sudo ln -s /opt/lampp/bin/phpcpd /usr/bin/phpcpd
sudo ln -s /opt/lampp/bin/pecl /usr/bin/pecl
sudo ln -s /opt/lampp/bin/phpize /usr/bin/phpize
sudo ln -s /opt/lampp/bin/php-config /usr/bin/php-config

