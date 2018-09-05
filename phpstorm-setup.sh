#!/bin/bash

[ $(id -u) != "0" ] && exec sudo "$0" "$@"
echo -e " \e[94mInstalling Jetbrains Toolbox.......\e[39m"
echo ""

URL="https://download-cf.jetbrains.com/toolbox/jetbrains-toolbox-1.6.2914.tar.gz"

FILE=$(basename ${URL})

DEST=$PWD/$FILE
DIR="/opt/jetbrains-toolbox"
if [ ! -d "$DIR" ]; 
then
	echo ""
	echo -e "\e[94m Downloading Jetbrains Toolbox files.....\e[39m"
	echo ""
	wget -cO  ${DEST} ${URL} --read-timeout=5 --tries=0
	echo ""
	echo -e "\e[32m Jetbrains Toolbox Download complete.\e[39m"
	echo ""

	echo ""
	echo  -e "\e[94m Installing Jetbrains Toolbox  to $DIR\e[39m"
	echo ""
	if mkdir ${DIR}; then
	    tar -xzf ${DEST} -C ${DIR} --strip-components=1
	fi

	chmod -R +rwx ${DIR}
	touch ${DIR}/jetbrains-toolbox.sh
	echo "#!/bin/bash" >> $DIR/jetbrains-toolbox.sh
	echo "$DIR/jetbrains-toolbox" >> $DIR/jetbrains-toolbox.sh

	ln -s ${DIR}/jetbrains-toolbox.sh /usr/local/bin/jetbrains-toolbox
	chmod -R +rwx /usr/local/bin/jetbrains-toolbox
	chmod -R 777 /usr/local/bin/jetbrains-toolbox
	echo ""
	rm ${DEST}
	echo -e "\e[32m Jetbrains Toolbox Installation Done.\e[39m"
	echo ""
fi

echo -e "\e[95m Run 'jetbrains-toolbox' to install PhpStorm.  \e[39m"
echo ""
echo -e "\e[95m Then Open PhpStorm from the menu and setup MEQP.  \e[39m"
echo ""
