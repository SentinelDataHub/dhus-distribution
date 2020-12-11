#!/bin/bash

if [ $# -ne 4 ]; then
  echo "Usage: $0 <JDBCDriver> <JDBCUrl> <login> <password>"
  exit 1
fi

java -cp "etc:lib/*" org.dhus.migration.DataBaseMigrationTool "$1" "$2" "$3" "$4"
