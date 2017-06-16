#!/bin/sh
BASENAME=`basename $0`
SCRIPT_DIR=`dirname $0`
PID_FILE=dhus.pid

(
   cd $SCRIPT_DIR

   if [ -f $PID_FILE ]
   then
      PID=`cat $PID_FILE`
      echo "Stopping old dhus at PID $PID"
      kill $PID && \
      while [ -e /proc/$PID ]; do sleep 0.1; done && \
      echo "Old Dhus stopped."
      rm -f $PID_FILE
   else
      echo "no $PID_FILE file found, stop ignored."
   fi
)
