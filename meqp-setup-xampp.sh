echo -e "\e[94m PHP Code Sniffer Installing......\e[39m"
printf "\n" | sudo /opt/lampp/bin/pear install --alldeps php_codesniffer
echo ""
echo -e "\e[32m PHP Code Sniffer Installed Successfully.\e[39m"
echo ""

echo -e "\e[94m MEQP Standards Installing......\e[39m"
git clone https://github.com/magento/marketplace-eqp.git
sudo cp -R marketplace-eqp/MEQP1 /opt/lampp/lib/php/PHP/CodeSniffer/src/Standards/MEQP1
sudo cp -R marketplace-eqp/MEQP2 /opt/lampp/lib/php/PHP/CodeSniffer/src/Standards/MEQP2
sudo cp -R marketplace-eqp/MEQP /opt/lampp/lib/php/PHP/CodeSniffer/src/Standards/MEQP

sudo sed -i "18irequire_once('/opt/lampp/lib/php/PHP/CodeSniffer/src/Standards/MEQP/Utils/Helper.php');" '/opt/lampp/lib/php/PHP/CodeSniffer/autoload.php'

echo ""
echo -e "\e[32m MEQP Standards Installed Successfully.\e[39m"
echo ""

echo -e "\e[94m PHP Mess Detector Installing......\e[39m"
printf "\n" | sudo /opt/lampp/bin/pear channel-discover pear.phpmd.org
printf "\n" | sudo /opt/lampp/bin/pear channel-discover pear.pdepend.org
printf "\n" | sudo /opt/lampp/bin/pear install --alldeps phpmd/PHP_PMD
echo ""
echo -e "\e[32m PHP Mess Detector Installed Successfully.\e[39m"
echo ""


echo -e "\e[32mInstallation completed.\e[39m"
echo ""

echo "To use Code Sniffer: "
echo ""
echo -e "\e[94m /opt/lampp/bin/phpcs --report=xml --report-file=/path/to/report.xml /path/to/code --standard=MEQP2 --severity=10 -p\e[39m"
echo ""
