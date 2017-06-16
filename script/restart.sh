#!/bin/sh
BASENAME=`basename $0`
SCRIPT_DIR=`dirname $0`
LOG_DIR="$SCRIPT_DIR/../logs"
TOMCAT_HOME="$SCRIPT_DIR/../var/tomcat/webapps/ROOT/home/"

(
   cd $SCRIPT_DIR

   if [ -f stop.sh ]
   then
      /bin/sh stop.sh
   else
      echo "stop.sh script not found, ignored."
   fi

   if [ -f start.sh ]
   then
      nohup /bin/sh start.sh &> $LOG_DIR/logs.txt &
      if [ -f dhus.html ] && [ -d $TOMCAT_HOME ]
      then
         echo "Waiting Dhus completion initialization."
         ( sed -r '/Server is ready.../q' <( exec tail -n +0 -f $LOG_DIR/logs.txt ); kill $! ) &> /dev/null
         echo "Copying extra resources into Dhus directories"
         cp -f dhus.html $TOMCAT_HOME
      fi
   else
      echo "start.sh script not found."
   fi
)
