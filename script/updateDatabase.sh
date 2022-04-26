#!/bin/bash

if [ $# -ne 4 ]; then
  echo "Usage: $0 <JDBCDriver> <JDBCUrl> <login> <password>"
  exit 1
fi

java -Dlog4j.configurationFile=etc/log4j2.xml -cp "lib/*" org.dhus.migration.DataBaseMigrationTool "$1" "$2" "$3" "$4"
