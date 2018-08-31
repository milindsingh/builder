
echo -e "\e[94m PHP 5.6 Installing in OS......\e[39m"
sudo add-apt-repository -y ppa:ondrej/php 
sudo apt update -y -qq 

echo ""
echo -e "\e[94m Running system upgrades......\e[39m"
sudo apt upgrade -y -qq 
echo -e "\e[32m System Upgrades Installed Successfully.\e[39m"
echo ""

sudo apt install -y php5.6 php5.6-mbstring php5.6-mcrypt php5.6-mysql php5.6-xml
sudo apt install -y php5-dev
echo ""
echo -e "\e[32m PHP 5.6 Installed Successfully.\e[39m"
echo ""

echo -e "\e[94m PHP 7.0 Installing in OS......\e[39m"
echo ""

sudo apt install -y php7.0 php7.0-mysql php7.0-mbstring php7.0-mcrypt php7.0-xml
echo ""
echo -e "\e[32m PHP 7.0 Installed Successfully.\e[39m"
echo ""

echo -e "\e[94m PHP Code Sniffer Installing......\e[39m"
printf "\n" | sudo apt install -y php-pear
printf "\n" | sudo pear install PHP_CodeSniffer
echo ""
echo -e "\e[32m PHP Code Sniffer Installed Successfully.\e[39m"
echo ""

echo -e "\e[94m MEQP Standards Installing......\e[39m"
git clone https://github.com/magento/marketplace-eqp.git
sudo cp -R marketplace-eqp/MEQP1 /usr/share/php/PHP/CodeSniffer/src/Standards/
sudo cp -R marketplace-eqp/MEQP2 /usr/share/php/PHP/CodeSniffer/src/Standards/
sudo cp -R marketplace-eqp/MEQP /usr/share/php/PHP/CodeSniffer/src/Standards/
echo ""
echo -e "\e[32m MEQP Standards Installed Successfully.\e[39m"
echo ""

echo -e "\e[94m PHP Mess Detector Installing......\e[39m"
printf "\n" | sudo pear channel-discover pear.phpmd.org
printf "\n" | sudo pear channel-discover pear.pdepend.org
printf "\n" | sudo pear install --alldeps phpmd/PHP_PMD


echo ""
echo -e "\e[32m PHP Mess Detector Installed Successfully.\e[39m"
echo ""

echo -e "\e[32mInstallation completed.\e[39m"
echo ""

echo "To use Code Sniffer: "
echo ""
echo -e "\e[94mphpcs --report=xml --report-file=/opt/lampp/htdocs/jurn/mantagift/app/code/Ced/Advance/report.xml /opt/lampp/htdocs/jurn/mantagift/app/code/Ced/Advance --standard=MEQP2 --severity=10 -p\e[39m"
echo ""
