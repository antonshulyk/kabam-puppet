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
npm cache clean

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
	else 
		echo "Bower install successfull"
		echo "Stopping ${APP} app"
		pm2 stop ${APP}
		pm2 delete ${APP}

		rm -f ${GREEN_APP_ROOT_DIR}

		#Creating the link to newly downloaded code
		ln -s ${BLUE_APP_ROOT_DIR} ${GREEN_APP_ROOT_DIR}

		cd  ${GREEN_APP_ROOT_DIR}
		source /home/nodejs/${APP}_env.properties
		pm2 start index.js --name ${APP} -i 2
		echo "Started ${APP} app"

		exit 0
	fi
done

exit 1
