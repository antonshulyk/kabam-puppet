#!/bin/bash

SERVER_NAME=$1
TOMCAT_DIR=/usr/local/${SERVER_NAME}

echo "Stopping <%= user %> server $TOMCAT_DIR"
$TOMCAT_DIR/bin/shutdown.sh
sleep 20

PID=`ps -ef | grep java | grep $SERVER_NAME | awk '{print $2}'`

if [[ -z $PID ]]; then
  echo "Tomcat already stopped for server $SERVER_NAME no need to forcefull shutdown"
else
  echo "Killing the <%= user %> with process id $PID"
  kill -9 $PID
fi

rm -rf $TOMCAT_DIR/logs/*

