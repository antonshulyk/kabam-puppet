#!/bin/bash

SERVER_NAME=$1
/home/<%= user %>/release/stopServer.sh $SERVER_NAME
/home/<%= user %>/release/startServer.sh $SERVER_NAME

