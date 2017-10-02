#!/bin/bash

DHUS_PATH=$1
DHUS_INCOMING=$2
DHUS_VAR=$3
DHUS_WEB_CLIENT_PORT=$4

mkdir -p $DHUS_INCOMING
mkdir -p $DHUS_VAR

sed -i -- 's/Xms..g/Xms512m/g; s/Xmx..g/Xmx512m/g' $DHUS_PATH/start.sh
sed -i -- "s#local_dhus#"$DHUS_VAR"#g" $DHUS_PATH/etc/dhus.xml
sed -i -- "s#8081#"$DHUS_WEB_CLIENT_PORT"#g" $DHUS_PATH/etc/server.xml
chmod +x $DHUS_PATH/start.sh $DHUS_PATH/stop.sh $DHUS_PATH/restart.sh

