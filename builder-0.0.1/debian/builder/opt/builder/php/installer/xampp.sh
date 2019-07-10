#!/usr/bin/env bash

USER=$(whoami)
EXE_PATH=$PWD
HOME_USER_PATH="/home/$USER"
XAMPP_BIN="/opt/lampp/bin"

XAMPP_NAME7_2=xampp-linux-x64-7.2.20-0-installer.run
XAMPP_URL7_2=https://www.apachefriends.org/xampp-files/7.2.20/xampp-linux-x64-7.2.20-0-installer.run
XAMPP_PATH7_2=/opt/lampp7.2

XAMPP_NAME7_3=xampp-linux-x64-7.3.7-0-installer.run
XAMPP_URL7_3=https://www.apachefriends.org/xampp-files/7.3.7/xampp-linux-x64-7.3.7-0-installer.run
XAMPP_PATH7_3=/opt/lampp7.3

XAMPP_NAME5=xampp-linux-x64-5.6.40-0-installer.run
XAMPP_URL5=https://www.apachefriends.org/xampp-files/5.6.40/xampp-linux-x64-5.6.40-0-installer.run
XAMPP_PATH5=/opt/lampp5

declare -a XAMPP_VERSIONS=(
 "5"
 "7_2"
 "7_3"
)
for i in "${XAMPP_VERSIONS[@]}"
do
    eval XAMPP_NAME=( \${XAMPP_NAME$i} ) ;
    eval XAMPP_PATH=( \${XAMPP_PATH$i} ) ;
    eval XAMPP_URL=( \${XAMPP_URL$i} ) ;
    read -p "Do you want to install XAMPP PHP $i? " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        if [ -f "$BUILDER_TMP$XAMPP_NAME" ]
			then
				echo -e "\e[94m Using XAMPP with PHP $i file: '$XAMPP_NAME' ......\e[39m"
			else
				echo ""
				echo -e "\e[94m Downloading XAMPP with PHP $i......\e[39m"
				echo ""
				wget ${XAMPP_URL} -P ${BUILDER_TMP}
				echo ""
				echo -e "\e[32m Downloaded XAMPP with PHP $i Successfully.\e[39m"
				echo ""
		fi

		echo -e "\e[94m Installing XAMPP with PHP $i in '/opt/' ......\e[39m"
		echo ""

		#Making executable
		sudo chmod +x ${BUILDER_TMP}${XAMPP_NAME}

		#Installing xampp
		yes Y | sudo ${BUILDER_TMP}${XAMPP_NAME} --mode text --launchapps 0 --enable-components xampp_developer_files
		echo ""

		#Moving lampp
		sudo mv /opt/lampp ${XAMPP_PATH}

		#Change the permission of htdocs
		cd ${XAMPP_PATH}/htdocs
		sudo find . -type f -exec chmod 644 {} \;
		sudo find . -type d -exec chmod 755 {} \;
		echo ""
		echo -e "\e[32m Installed XAMPP with PHP $i  Successfully.\e[39m"
		echo ""

    fi
done

#Changing to exe path
cd ${EXE_PATH}

echo "#!/usr/bin/env bash

if [ ! -z \"$1\" -a \"$1\" != \" \" ] && [ -d \"/opt/lampp${1}\" ];
 then
        if [[ -f '/opt/lampp/xampp' && -L '/opt/lampp/xampp'  ]]
            then
                    sudo /opt/lampp/xampp stop
                    sudo rm /opt/lampp
        fi

        sudo ln -s /opt/lampp${1} /opt/lampp
        echo
        sudo /opt/lampp/xampp start
        echo -e \"\e[32m XAMPP${1} started.\e[39m\"
        exit
fi;


if [ -d '/opt/lampp' ]
then
	echo
	echo \"Available version:\"
	ls -l /opt/lampp | awk '{print $11}'
fi

echo
echo \"Which XAMPP would you like to activate?\"
echo
echo \"Enter '7_2' for XAMPP with PHP 7.2\"
echo
echo \"Enter '7_3' for XAMPP with PHP 7.3\"
echo
echo \"Enter '5' for XAMPP with PHP 5\"
echo

read version

echo
if [[ -f '/opt/lampp/xampp' && -L '/opt/lampp/xampp'  ]]
then
	sudo /opt/lampp/xampp stop
	sudo rm /opt/lampp
fi

if [ -d \"/opt/lampp\${version}\" ]
then
	sudo ln -s /opt/lampp\${version} /opt/lampp

	echo
	sudo /opt/lampp/xampp start
	echo -e \"\e[32m XAMPP\${version} started.\e[39m\"
fi

echo" > "${BUILDER_TMP}xampp.sh"
sudo cp "${BUILDER_TMP}/xampp.sh" "/usr/bin/xampp"
sudo chmod +x "/usr/bin/xampp"

sudo echo "if [ -d \"${XAMPP_BIN}\" ] ; then
        PATH=\"${XAMPP_BIN}:\$PATH\"
    	fi"  >> /home/${USER}/.profile
sudo echo "if [ -d \"${XAMPP_BIN}\" ] ; then
        PATH=\"${XAMPP_BIN}:\$PATH\"
    	fi"  >> /home/${USER}/.bashrc

source /home/${USER}/.profile
source /home/${USER}/.bashrc
xampp 7

echo ""
echo -e "\e[32m Installed and Setup XAMPP in your system Successfully.\e[39m"
echo ""




