GIT='0'
BUILDER_TMP="/tmp/builder/"

read -p "Install Xdebug from Git Source [Y|N]? " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    GIT='1'
fi

IP=$(hostname -I| cut -d " " -f 1)

echo "Xdebug installation started........."
echo ""

echo "Removing global PHP........."
echo ""
sudo apt purge -y php-* --force-yes

echo "Installing dependencies........."
echo ""
sudo apt install -y autoconf --force-yes
sudo apt install -y libc6-dev --force-yes
echo ""

if [ "$GIT" = "1" ];
then
    echo "Installing via Git........."
    EXTENSIONS_PATH='/opt/lampp/lib/php/extensions'

    if [ ! -d "./xdebug" ];
    then
	sudo apt-get install -y git
	git clone --single-branch -b xdebug_2_8 https://github.com/xdebug/xdebug.git ${BUILDER_TMP}xdebug
    fi

    sudo chmod 777 -R ${BUILDER_TMP}xdebug
    cd ${BUILDER_TMP}xdebug
    /opt/lampp/bin/phpize
    ./configure --enable-xdebug --with-php-config=/opt/lampp/bin/php-config
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
" | sudo tee -a "/opt/lampp/etc/php.ini"

	echo "Restarting xampp........."
	sudo /opt/lampp/xampp restart
else
	echo "xdebug.so not available.........."
fi

echo "Xdebug installation completed........."
echo ""

echo "Restarting xampp........."
sudo /opt/lampp/xampp restart

echo "PHP Version:"
echo
php -v
