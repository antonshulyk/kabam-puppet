#!/bin/bash
RELEASE_DIR=$1
SERVER_NAME=$2
TOMCAT_DIR=/usr/local/$2

/home/<%= user %>/release/stopServer.sh $SERVER_NAME

echo "Clearing ROOT directory $TOMCAT_DIR/webapps/ROOT/"
rm -vrf $TOMCAT_DIR/webapps/ROOT/*;

echo "Placing the new content in web server"
cp -vr $RELEASE_DIR/* $TOMCAT_DIR/webapps/ROOT/;

/home/<%= user %>/release/startServer.sh $SERVER_NAME

