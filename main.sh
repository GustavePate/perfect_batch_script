#!/bin/bash

. ./functions_library.bash

# get date YYYYMMDD
TODAY=`date +%Y%m%d`
LAUNCH_TIME=`date --rfc-3339=seconds`


base=`dirname $0`

# init logger
LOGGER=$base"/main.log"
if [ -f $LOGGER ];then
    rm $LOGGER
    touch $LOGGER
fi
LOG_MODE="stdout"
#LOG_MODE="discret"

GET_BUILD_NUMBER=$base/getBuildNumber.sh
PUSH_2_NEXUS=$base/pushArchiveToNexus.sh
DEPLOY=$base/deploy.sh

#GET_BUILD_NUMBER=$base/getBuildNumber-rec.sh
#PUSH_2_NEXUS=$base/pushArchiveToNexus-rec.sh
#DEPLOY=$base/deploy-rec.sh

# Usage info
function usage {
cat << EOF

USAGE: $0 [-h] --application APPLICATION_NAME

Build and Delivery in Buildfactory.

    -h                              Display this help and exit.
    --application APPLICATION_NAME  Name of the application in BuildFactory. Ex: credics
EOF

exit

}

# Variables initialization
APPLICATION="empty"

while test $# -gt 0; do
	case "$1" in
		-h|--help)
			usage
			exit -1
			;;
		--application)
			shift
			APPLICATION=$1
			shift
			;;
		*)
			usage
			exit -1
			;;
	esac
done



l_check_user_input $APPLICATION "--application"
l_execute "ls"
l_log  "INFO" "THE END"

