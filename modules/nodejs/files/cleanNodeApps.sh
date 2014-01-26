#!/bin/bash

NODE_APP=$1

CURRENT_TIME=`date +%y%m`
NODE_APP_SEARCH_PATTERN=${NODE_APP}-${CURRENT_TIME}

cd nodeapps

DIR_COUNT=`ls -lrtd ${NODE_APP_SEARCH_PATTERN}* | wc -l`

echo "Totoal directories of ${NODE_APP} are ${DIR_COUNT}"

echo "Below directories will be removed"
ls -lrtd ${NODE_APP_SEARCH_PATTERN}* | head -$(($DIR_COUNT-2)) | awk '{print $9}'

rm -rf `ls -lrtd ${NODE_APP_SEARCH_PATTERN}* | head -$(($DIR_COUNT-2)) | awk '{print $9}'`
