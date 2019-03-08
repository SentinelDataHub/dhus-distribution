#!/bin/bash

if [ $# -ne 1 ]; then
  echo "Usage: $0 <path to dhus.xml>"
  exit 1
fi

java -cp "etc:lib/*" fr.gael.dhus.ConfigurationConverter "$1"

