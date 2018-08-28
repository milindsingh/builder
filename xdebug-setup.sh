GIT='0'
IP=$(hostname -I| cut -d " " -f 1)

echo "Xdebug installation started........."
sudo apt-get install -y autoconf
sudo apt-get install -y git

if [ "$GIT" = "1" ];
then
    echo "Installing via Git........."
    EXTENSIONS_PATH='/opt/lampp/lib/php/extensions'

    if [ ! -d "./xdebug" ]; 
    then
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
