#!/bin/bash

APP=$1

source ${HOME}/.nvm/nvm.sh
nvm use 0.10.23

source /home/nodejs/${APP}_env.properties
cd ${HOME}/nodeapps/${APP}
pm2 start index.js --name ${APP} -i 2
