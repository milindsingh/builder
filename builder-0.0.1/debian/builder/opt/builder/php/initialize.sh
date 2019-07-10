#!/usr/bin/env bash

export PATH=$PATH:/opt/lampp/bin
USER=$(whoami)

echo -e "\e[94m Installing Composer......\e[39m"

DIRECTORY="/home/${USER}/.composer"
if [ ! -d "$DIRECTORY" ]; then
    sudo mkdir "/home/$USER/.composer"
fi

sudo chmod 777 -R "/home/$USER/.composer"


echo ""
sudo curl -s https://getcomposer.org/installer | php
echo ""

sudo cp ./composer.phar /usr/local/bin/composer

sudo chmod 777 -R "/home/$USER/.composer"

echo -e "\e[32m Installed Composer Successfully.\e[39m"
echo ""
