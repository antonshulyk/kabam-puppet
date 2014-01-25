#!/bin/bash
APP=$1
PORT_NO=$2
echo "starting with execution"
nvm use 0.10.23

cd /home/nodejs/nodeapps/${APP}
cat /home/nodejs/${APP}_env.properties >> /var/log/${APP}.sys.log 2>&1  
source /home/nodejs/${APP}_env.properties

npm start >> /var/log/${APP}.sys.log 2>&1
echo "execution done"
