#!/bin/bash

SERVER_NAME=$1
TOMCAT_DIR=/usr/local/${SERVER_NAME}

echo "Starting <%= user %> server"
$TOMCAT_DIR/bin/startup.sh

