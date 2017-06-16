#!/bin/bash
# Call this command line as followed:
# nohup /bin/bash start.sh &> /logs-path/logs.txt &
#
# Data Hub Service configuration is done inside file "etc/dhus-config.xml".
#
# DHuS command line follows VM standard command lines (See Java VM documentation)
#
# DHuS Internal properties (Many of these properties are experimental, please use carefully)
# -------------------------
#
# country.synonyms=/path/to/file path to the definition of users countries synonyms.
#
# webapp.excluded=webapp the name of the webapp to not start at system startup (i.e. "fr.gael.dhus.gwt.GWTWebapp").
#
# Archive.check=true|false     (default=false) force system check at dhus startup
#
# Archive.forceReindex=true|false (default=false) force all the products indexes being re-indexed.
#
# Archive.incoming.relocate=true|false (default=false) force the relocation of all the products of incoming
#
# Archive.incoming.relocate.path=/path/to/relocation (default="") give the new location path to relocate incoming directory.
#                              If no pas is provided, incoming will be relocated in its current directory.
#
# Archive.processings.clean=true|false (default=false) clean all the interrupted processings instead of recover them.
#
# force.public=true|false (default=false) force all the product contained into DHuS become public.
#
# Archive.synchronizeLocal=true|false (default=false) force re-synchronization of local archive path at system startup.
#
# users.search.notification.force.inactive=true|false (default=false) deactivates all the user search notifications.
#
# checkUserConfiguration=true|false (default=false) activates schema aware validation of input xml configuration file.
#
# dhus.solr.reindex=true|false (default=false) recreate the Solr index from the database.
# action.record.inactive=true|false (default=false) full deactivates read/write statistics.
#
# dhus.scalability.active=true|false (default=false) activates scalability in DHuS
# dhus.scalability.local.protocol=   (default=http) local protocol to access this DHuS
# dhus.scalability.local.ip=         local ip to access this DHuS
# dhus.scalability.local.port=       (default=8080) local port to access this DHuS
# dhus.scalability.local.path=       local path to access this DHuS
# dhus.scalability.replicaId=1       (default=-1) replica's id; if not used, this node is considered as master
# dhus.scalability.dbsync.master=    URL of dhus master (poitning on root path)
# dhus.scalability.dbsync.clear=     (default=false) clear every system record about db synchronization stored in db (not replicated data)
#
# dhus.replication.exitonfailure=true|false (default=true) shutdown or not the replica on replication failure.
#
# dhus.sync.download_attempts=       (default=10) number of download attempts (-1 for infinite, must be at least 1)
#
# Required properties:
# --------------------
# -Dcom.sun.media.jai.disableMediaLib=true : to be removed if media jai native
#                              library is provided. DHuS does not requires these
#                              libraries for optimization.
#
# -Duser.timezone=UTC Mandatory parameter to force the DHuS timezone to a standard,
#                              not depending on the operating system settings.
#
# -Dsun.zip.disableMemoryMapping=true currently mandatory to avoid a crash in zip library usage.
#
#

check_dir ()
{
   if [ -d $1 ]
   then
      echo "[\033[32;1mOk\033[0m]".
      return 0
   else
       echo "[\033[31;1mKo\033[0m]".
       return 1
   fi
}

fail ()
{
   echo "$@" >&2 
   exit 1
}

get_arch ()
{
  case `uname -m` in
     amd64|x86_64)
        echo "x86_64"
        ;;
   esac
}


if [ -f start_first.sh ] 
then
   /bin/sh start_first.sh
fi

BASENAME=`basename $0`
SCRIPT_DIR=`dirname $0`
DHUS_HOME=${DHUS_HOME-`(cd ${SCRIPT_DIR:-.}; pwd)`}
DHUS_LIB=${DHUS_HOME}/lib

arch=$(get_arch)
[ -z "${arch}" ] && fail "Unsupported architecture '`uname -m`'."

NATIVE_LIBRARIES=${DHUS_LIB}/native/`uname -s`-${arch}

ERROR_COUNT=0
if [ ! -z "${DEBUG}" ]
then
   echo BASENAME=${BASENAME}
   echo -n "SCRIPT_DIR=${SCRIPT_DIR} "
   check_dir $SCRIPT_DIR
   ERROR_COUNT=$((ERROR_COUNT+$?))

   echo -n "DHUS_HOME=${DHUS_HOME} "
   check_dir $DHUS_HOME
   ERROR_COUNT=$((ERROR_COUNT+$?))

   echo -n "DHUS_LIB=${DHUS_LIB} "
   check_dir $DHUS_LIB
   ERROR_COUNT=$((ERROR_COUNT+$?))
 
   echo -n "NATIVE_LIBRARIES=${NATIVE_LIBRARIES} "
   check_dir $NATIVE_LIBRARIES
   ERROR_COUNT=$((ERROR_COUNT+$?))

   echo -n "Check libraries "
   count=$(ls $DHUS_LIB 2>/dev/null | wc -l)
   if [ "$count" -lt 5 ]
   then
      echo "[\033[31;1mKo\033[0m]".
      ERROR_COUNT=$((ERROR_COUNT+1))
   else
      echo "[\033[32;1mOk\033[0m]".
   fi

   echo -n "  - Core library present "
   count=$(ls $DHUS_LIB/dhus-core*.jar 2>/dev/null | wc -l)
   if [ "$count" -ne 1 ]
   then
      
      echo "[\033[31;1mKo\033[0m]".
      ERROR_COUNT=$((ERROR_COUNT+1))
   else
      echo "[\033[32;1mOk\033[0m]".
   fi

   if [ $ERROR_COUNT -gt 0 ]
   then
      fail "Wrong system configuration."
   fi
fi

java -server -XX:MaxPermSize=256m -Xms12g -Xmx12g          \
     -Djava.library.path=${NATIVE_LIBRARIES}               \
     -Duser.timezone=UTC                                   \
     -Dcom.sun.media.jai.disableMediaLib=true              \
     -Dsun.zip.disableMemoryMapping=true                   \
     -Ddhus.scalability.active=false                       \
     -Ddhus.scalability.local.ip=127.0.0.1   \
     -cp "etc:lib/*" fr.gael.dhus.DHuS &

PID=$!
echo $PID > dhus.pid
wait $PID

if [ $? -eq 8 ]
then
   . $0
fi
