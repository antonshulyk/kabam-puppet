#!/bin/bash

APP=$1
source ${HOME}/.nvm/nvm.sh
nvm use 0.10.23

pm2 stop all
pm2 delete ${APP}
