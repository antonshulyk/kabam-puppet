#!/bin/bash

source /home/nodejs/.nvm/nvm.sh

echo "Installing Protractor and Selenium"

nvm install 0.10.17
nvm use 0.10.17

cd /home/nodejs
npm install -g protractor

result=$?
if [ $result != 0 ]; then
        echo "Protractor install failed. exit!"
        exit 1
fi

echo "Protractor install success."

exit 1
