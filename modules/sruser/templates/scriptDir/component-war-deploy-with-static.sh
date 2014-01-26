#!/bin/bash
RELEASE_ARCHIVE=$1
SERVER_NAME=$2
TOMCAT_DIR=/usr/local/$2
STATIC_ROOT=$3

/home/<%= user %>/release/stopServer.sh $SERVER_NAME

echo "Clearing ROOT directory"
rm -rf $TOMCAT_DIR/webapps/ROOT/*;

echo "Placing the new content in web server"
unzip $RELEASE_ARCHIVE -d $TOMCAT_DIR/webapps/ROOT/;

cp -r $TOMCAT_DIR/webapps/ROOT/static/* $STATIC_ROOT

/home/<%= user %>/release/startServer.sh $SERVER_NAME

