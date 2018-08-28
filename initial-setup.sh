#!/usr/bin/env bash

EXE_PATH=$PWD
HOME_USER_PATH="/home/cedcoss"

XAMPP_NAME=xampp-linux-x64-7.0.27-0-installer.run
XAMPP_URL=https://www.apachefriends.org/xampp-files/7.0.27/xampp-linux-x64-7.0.27-0-installer.run
XAMPP_PATH=/opt/lampp7

XAMPP5_NAME=xampp-linux-x64-5.6.33-0-installer.run
XAMPP5_URL=https://www.apachefriends.org/xampp-files/5.6.33/xampp-linux-x64-5.6.33-0-installer.run
XAMPP5_PATH=/opt/lampp5


echo -e "\e[94m Installing XAMPP in your system......\e[39m"
echo ""

if [ ! -d "$XAMPP_PATH" ]; 
then
		if [ -f "$XAMPP_NAME" ]
			then
				echo -e "\e[94m Using XAMPP with PHP 7.027 file: '$XAMPP_NAME' ......\e[39m"
			else
				echo ""
				echo -e "\e[94m Downloading XAMPP with PHP 7.027......\e[39m"
				echo ""
				wget ${XAMPP_URL}
				echo ""
				echo -e "\e[32m Downloaded XAMPP with PHP 7.027 Successfully.\e[39m"
				echo ""
		fi

		echo -e "\e[94m Installing XAMPP with PHP 7.027 in '/opt/' ......\e[39m"
		echo ""

		#Making executable
		sudo chmod +x ${XAMPP_NAME}

		#Installing xampp
		yes Y | sudo ./${XAMPP_NAME} --mode text --launchapps 0 --enable-components xampp_developer_files
		echo ""

		#Moving lampp
		sudo mv /opt/lampp ${XAMPP_PATH}

		#Change the perission of htdocs
		cd ${XAMPP_PATH}/htdocs
		sudo find . -type f -exec chmod 644 {} \;
		sudo find . -type d -exec chmod 755 {} \;
		echo ""
		echo -e "\e[32m Installed XAMPP with PHP 7.027  Successfully.\e[39m"
		echo ""
fi

#Chinging to exe path
cd ${EXE_PATH}

if [ ! -d "$XAMPP5_PATH" ]; 
then
		if [ -f "$XAMPP5_NAME" ]
			then
				echo -e "\e[94m Using XAMPP with PHP 5.6 file: '$XAMPP5_NAME' ......\e[39m"
			else
				echo ""
				echo -e "\e[94m Downloading XAMPP with PHP  5.6 .....\e[39m"
				echo ""
				wget ${XAMPP5_URL}
				echo ""
				echo -e "\e[32m Downloaded XAMPP with PHP  5.6 Successfully.\e[39m"
				echo ""
		fi

		echo -e "\e[94m Installing XAMPP with PHP  5.6 in '/opt/' ......\e[39m"
		echo ""

		#Making executable
		sudo chmod +x ${XAMPP5_NAME}

		#Installing xampp
		yes Y | sudo ./${XAMPP5_NAME} --mode text --launchapps 0 --enable-components xampp_developer_files
		echo ""

		#Moving lampp
		sudo mv /opt/lampp ${XAMPP5_PATH}

		#Change the perission of htdocs
		cd ${XAMPP5_PATH}/htdocs
		sudo find . -type f -exec chmod 644 {} \;
		sudo find . -type d -exec chmod 755 {} \;
		echo ""
		echo -e "\e[32m Installed XAMPP with PHP  5.6 Successfully.\e[39m"
		echo ""
fi

#Chinging to exe path
cd ${EXE_PATH}

echo "#!/bin/bash
if [ -d '/opt/lampp' ]
then
	echo
	echo \"Here's the versions that you have:\"
	ls -l /opt/lampp | awk '{print $11}'
fi

echo
echo \"Which XAMPP would you like to activate?\"
echo
echo \"1. 7 for XAMPP with PHP 7.0\"
echo
echo \"2. 5 for XAMPP with PHP 5.6\"

read version

echo
if [ -f '/opt/lampp/xampp' ]
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

echo" > "xampp.sh"
sudo cp "${PWD}/xampp.sh" "/usr/bin/xampp.sh"
sudo chmod +x "/usr/bin/xampp.sh"

cd ${HOME_USER_PATH}
echo "alias xampp='/usr/bin/xampp.sh'"  >> ".bashrc"


echo ""
echo -e "\e[32m Installed and Setup XAMPP in your system Successfully.\e[39m"
echo ""




