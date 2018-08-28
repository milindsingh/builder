git clone --depth=1 "git://github.com/phalcon/cphalcon.git"
cd cphalcon/build
yes Y 2>/dev/null | sudo apt-get install libpcre3-dev
sudo ./install --with-php-config=/opt/lampp/bin/php-config
echo -e "\e[94m write extension=phalcon.so in your php.ini and restart server......\e[39m"
echo -e "\e[94m Install the phalcon plugin for using the phalcon in your ide......\e[39m"
