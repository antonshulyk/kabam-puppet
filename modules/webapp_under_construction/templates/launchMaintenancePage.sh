#!/bin/bash

#Name of the tomcat server
TOMCAT_SERVER=$1
#Symbolic link of the existing app
APP_TO_BRINGDOWN=$2

/home/<%= user %>/release/stopServer.sh ${TOMCAT_SERVER}
rm -f ${APP_TO_BRINGDOWN}
ln -s <%= folder_location %> ${APP_TO_BRINGDOWN}
/home/<%= user %>/release/startServer.sh ${TOMCAT_SERVER}

