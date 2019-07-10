USER=$(whoami)

#MODE="PEAR" 
MODE="COMPOSER"

echo -e "\e[94m Removing Global PHP......\e[39m"
sudo apt purge -y php-* --force-yes

echo -e "\e[94m Installing Git......\e[39m"
sudo apt install -y git --force-yes
echo ""

echo -e "\e[94m Installing Autoconf......\e[39m"
sudo apt install -y autoconf --force-yes
echo ""

# PHP 7.2 does not support pear install.
if [ ${MODE}="COMPOSER" ]; then
    echo -e "\e[94m PHP Code Sniffer Installing......\e[39m"
	COMPOSER_BIN="/home/${USER}/.composer/vendor/bin"
	COMPOSER_CS_STANDARDS="/home/${USER}/.composer/vendor/squizlabs/php_codesniffer/src/Standards/"
    composer global require "squizlabs/php_codesniffer=*"
    sudo echo "if [ -d \"${COMPOSER_BIN}\" ] ; then
        PATH=\"${COMPOSER_BIN}:\$PATH\"
    	fi"  >> /home/${USER}/.profile
   	sudo echo "if [ -d \"${COMPOSER_BIN}\" ] ; then
        PATH=\"${COMPOSER_BIN}:\$PATH\"
    	fi"  >> /home/${USER}/.bashrc
	echo ""
	echo -e "\e[32m PHP Code Sniffer Installed Successfully.\e[39m"
	echo ""

	echo -e "\e[94m MEQP Standards Installing......\e[39m"
	sudo rm -rf ./marketplace-eqp
	git clone https://github.com/magento/marketplace-eqp.git
	sudo cp -R marketplace-eqp/MEQP1 ${COMPOSER_CS_STANDARDS}MEQP1
	sudo cp -R marketplace-eqp/MEQP ${COMPOSER_CS_STANDARDS}MEQP
	sudo sed -i "18irequire_once('${COMPOSER_CS_STANDARDS}MEQP/Utils/Helper.php');" "/home/${USER}/.composer/vendor/squizlabs/php_codesniffer/autoload.php"

	sudo rm -rf ./magento-coding-standard
	git clone https://github.com/magento/magento-coding-standard.git
	sudo cp -R magento-coding-standard/Magento2 ${COMPOSER_CS_STANDARDS}Magento2

	echo ""
	echo -e "\e[32m MEQP Standards Installed Successfully.\e[39m"
	echo ""
    source /home/${USER}/.profile
    source /home/${USER}/.bashrc

elif [ ${MODE}="PEAR" ]; then
	echo -e "\e[94m PHP Code Sniffer Installing......\e[39m"
	printf "\n" | sudo /opt/lampp/bin/pear install --alldeps php_codesniffer
	echo ""
	echo -e "\e[32m PHP Code Sniffer Installed Successfully.\e[39m"
	echo ""

	echo -e "\e[94m MEQP Standards Installing......\e[39m".

    sudo rm -rf ./marketplace-eqp
    git clone https://github.com/magento/marketplace-eqp.git
    sudo cp -R marketplace-eqp/MEQP1 ${COMPOSER_CS_STANDARDS}MEQP1
    sudo cp -R marketplace-eqp/MEQP ${COMPOSER_CS_STANDARDS}MEQP
    sudo sed -i "18irequire_once('${COMPOSER_CS_STANDARDS}MEQP/Utils/Helper.php');" "/home/${USER}/.composer/vendor/squizlabs/php_codesniffer/autoload.php"

    sudo rm -rf ./magento-coding-standard
    git clone https://github.com/magento/magento-coding-standard.git
    sudo cp -R magento-coding-standard/Magento2 ${COMPOSER_CS_STANDARDS}Magento2

	echo ""
	echo -e "\e[32m MEQP Standards Installed Successfully.\e[39m"
	echo ""
fi 

echo -e "\e[94m PHP Mess Detector Installing......\e[39m"
printf "\n" | sudo /opt/lampp/bin/pear channel-discover pear.phpmd.org
printf "\n" | sudo /opt/lampp/bin/pear channel-discover pear.pdepend.org
printf "\n" | sudo /opt/lampp/bin/pear install --alldeps phpmd/PHP_PMD
echo ""
echo -e "\e[32m PHP Mess Detector Installed Successfully.\e[39m"
echo ""


echo -e "\e[32mInstallation completed.\e[39m"
echo ""

echo "To show Code Sniffer Standards : "
echo "phpcs -i"
echo ""
echo "To use Code Sniffer: "
echo ""
echo -e "\e[94m phpcs --report=xml --report-file=/path/to/report.xml /path/to/code --standard=MEQP2 --severity=10 -p \e[39m"
echo ""
