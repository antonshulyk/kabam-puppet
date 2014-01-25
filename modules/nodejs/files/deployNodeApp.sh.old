#!/bin/bash

APP=$1
CURRENT_TIME=`date +%y%m%d_%H%M%S`
BLUE_APP_ROOT_DIR=${HOME}/nodeapps/${APP}-${CURRENT_TIME}
GREEN_APP_ROOT_DIR=${HOME}/nodeapps/${APP}

source ${HOME}/.nvm/nvm.sh

echo "Cleaning code directory"
mkdir ${BLUE_APP_ROOT_DIR}

echo "Copying the app content"
tar -vxzf ${APP}.tar.gz -C ${BLUE_APP_ROOT_DIR}
cd ${BLUE_APP_ROOT_DIR}
nvm use 0.10.23

npm install
result=$?
if [ $result != 0 ]; then
        echo "NPM install failed. exit!"
        exit 1
fi

for i in {1..5}; do
	rm -rf .bower-*
	node_modules/bower/bin/bower install
	result=$?
	if [ $result != 0 ]; then
		echo "Bower install failed!!!!"
		#exit 1
	else 
		echo "Bower install successfull"
		echo "Stopping ${APP} app"
		sudo stop ${APP}

		rm -f ${GREEN_APP_ROOT_DIR}

		#Creating the link to newly downloaded code
		ln -s ${BLUE_APP_ROOT_DIR} ${GREEN_APP_ROOT_DIR}

		sudo start ${APP}
		echo "Started ${APP} app"

		exit 0
	fi
done

exit 1
