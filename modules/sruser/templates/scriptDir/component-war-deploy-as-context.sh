#!/bin/bash
RELEASE_ARCHIVE=$1
SERVER_NAME=$2
TOMCAT_DIR=/usr/local/$2

/home/<%= user %>/release/stopServer.sh $SERVER_NAME

echo "Clearing context directory"
rm -rvf $TOMCAT_DIR/webapps/${RELEASE_ARCHIVE}*;

echo "Placing the new content in web server"
cp -v /home/<%= user %>/${RELEASE_ARCHIVE}.war  $TOMCAT_DIR/webapps/;

/home/<%= user %>/release/startServer.sh $SERVER_NAME
