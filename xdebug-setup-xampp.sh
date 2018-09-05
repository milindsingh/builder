GIT='0'
IP=$(hostname -I| cut -d " " -f 1)

echo "Xdebug installation started........."
echo ""

echo "Removing global PHP........."
echo ""
sudo apt purge -y php-*  

echo "Installing dependencies........."
echo ""
sudo apt-get install -y autoconf
sudo apt install -y libc6-dev
echo ""

echo "Adding symlinks........"
sudo ln -s /opt/lampp/bin/php /usr/bin/php
sudo ln -s /opt/lampp/bin/phpcpd /usr/bin/phpcpd
sudo ln -s /opt/lampp/bin/pecl /usr/bin/pecl
sudo ln -s /opt/lampp/bin/phpize /usr/bin/phpize
sudo ln -s /opt/lampp/bin/php-config /usr/bin/php-config

if [ "$GIT" = "1" ];
then
    echo "Installing via Git........."
    EXTENSIONS_PATH='/opt/lampp/lib/php/extensions'

    if [ ! -d "./xdebug" ]; 
    then
	sudo apt-get install -y git
	git clone https://github.com/xdebug/xdebug.git
    fi

    cd xdebug
    sudo /opt/lampp/bin/phpize
    sudo ./configure --enable-xdebug --with-php-config=/opt/lampp/bin/php-config
    make
    sudo cp modules/xdebug.so /opt/lampp/lib/php/extensions
else
    echo "Installing via pecl........."
    sudo /opt/lampp/bin/pecl install xdebug
    EXTENSIONS_PATH=$(find /opt/lampp/lib/php/extensions/ -maxdepth 1 -type d -name '*no-debug-non-zts-*' -print -quit)
fi

if [ -f $EXTENSIONS_PATH/xdebug.so ];
then
	echo "Updating php.ini ........."
	echo "
[xdebug]
zend_extension=$EXTENSIONS_PATH/xdebug.so

xdebug.remote_enable=1

xdebug.remote_host=${IP}

xdebug.remote_handler=dbgp

xdebug.remote_mode=req

xdebug.remote_port=9000

xdebug.max_nesting_level=300

xdebug.ide_key=’PHPSTORM’

xdebug.remote_connect_back=1
"  >> "/opt/lampp/etc/php.ini"

	echo "Restarting xampp........."
	sudo /opt/lampp/xampp restart
else
	echo "Xdebug.so not available.........."
fi

echo "Xdebug installation completed........."
echo ""

echo "Restarting xampp........."
sudo /opt/lampp/xampp restart

