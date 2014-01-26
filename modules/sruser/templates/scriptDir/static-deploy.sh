#!/bin/bash
RELEASE_DIR=$1
STATIC_CONTENT_DIR=/var/www/lighttpd/static/$2
echo "Copying content from $RELEASE_DIR/static/* to $STATIC_CONTENT_DIR"
cp -r $RELEASE_DIR/static/* $STATIC_CONTENT_DIR;

