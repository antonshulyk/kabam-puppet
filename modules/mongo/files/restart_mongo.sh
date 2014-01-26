#!/bin/bash

MONGO_DATA_DIR=$1
if [ -f ${MONGO_DATA_DIR}/mongod.lock ]; then
  echo "Mongo lock file is present shutting down mongo"
  kill -9 `cat ${MONGO_DATA_DIR}/mongod.lock`
  rm -fv ${MONGO_DATA_DIR}/mongod.lock
else
  echo "Mongo is not running"
fi

echo "Using conf file ${MONGO_DATA_DIR}/mongod.conf"
#mongod -f ${MONGO_DATA_DIR}/mongod.conf
mongod -f ${MONGO_DATA_DIR}/mongod.conf

echo "Going to sleep so that mongo should be up"
sleep 60
