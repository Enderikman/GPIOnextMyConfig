#!/bin/bash
VERSION="1.0"

#get script path
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd $SCRIPTPATH

#if not root user, restart script as root
if [ "$(whoami)" != "root" ]; then
	echo "Switching to root user..."
	sudo bash $SCRIPT $*
	exit 1
fi

shopt -s nocasematch
if ! [[ "$1" == "-noupdate" ]]; then
    echo "Performing self-update..."
    git config --global user.email "none@none.com"
    git config --global user.name "none@none.com"
    git checkout master
    git stash
    git pull
    git stash pop
    git config --global --unset user.email
    git config --global --unset user.name
    exec /bin/bash update.sh -noupdate
fi
shopt -u nocasematch

# create bash custom commands
cp $SCRIPTPATH"/usr-bin-gpionext1" /usr/bin/gpionext1
config="CONFIG_PATH=${SCRIPTPATH}/config_manager1.py"
sed -i '1s#^#'$config'\n#g' /usr/bin/gpionext1
chmod 777 /usr/bin/gpionext1

sudo systemctl stop gpionext1
sudo systemctl daemon-reload
sudo systemctl start gpionext1
echo 'update complete'
