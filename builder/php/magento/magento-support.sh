#!/bin/bash
DIR=$(pwd)

ProgName=$(basename $0)
  
sub_help(){
    echo "Usage: $ProgName <subcommand> [options]\n"
    echo "Subcommands:"
    echo "    set-permissions [\magento\root\dir\path, default: .]"
    echo "    clean [\magento\root\dir\path, default: .]"
    echo ""
    echo "For help with each subcommand run:"
    echo "$ProgName <subcommand> -h|--help"
    echo ""
}
  
sub-set-permissions(){
    read -r -p "Confirm your magento directory: '$DIR'? [y/N] " response
	if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]
	then
		cd $DIR; # <your Magento install dir>
		find $DIR  -type f -exec chmod 644 {} \; # 644 permission for files 
		echo "Set 644 permission for files";
		find $DIR -type d -exec chmod 755 {} \; # 755 permission for directory 
		echo "Set 755 permission for directory ";
		find $DIR/var -type d -exec chmod 777 {} \; # 777 permission for var folder
		echo "Set 777 permission for var folder";
		find $DIR/pub/media -type d -exec chmod 777 {} \;
		find $DIR/pub/static -type d -exec chmod 777 {} \;
		chmod 777 ./app/etc
		chmod 644 ./app/etc/*.xml
		echo "All permissions updated successfully."
	else
		echo "Failed. exit"
	fi
}

sub-clean(){
	cd $DIR; # <your Magento install dir>
	$(sudo /opt/lampp/bin/php bin/magento cache:clean)
	echo "Done. exit"
}
    
subcommand=$1
case $subcommand in
    "" | "-h" | "--help")
        sub_help
        ;;
    *)
        shift
        sub-${subcommand} $@
        if [ $? = 127 ]; then
            echo "Error: '$subcommand' is not a known subcommand." >&2
            echo "       Run '$ProgName --help' for a list of known subcommands." >&2
            exit 1
        fi
        ;;
esac