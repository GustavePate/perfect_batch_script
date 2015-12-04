
# check_user_input $APPLICATION "--application"
function l_check_user_input {
    # $1 parameter
    # $2 command line option name
    echo "INFO check_user_input $2 $1"
    if [ $1 == "empty" ]; then
        echo "ERROR the $2 option is mandatory"
        usage
        exit 1
    fi
}


#check_quota $APPNAME
function l_check_quota {
    # $1 appname
    # $MAX_BUILD build max / day

    echo "INFO check quota for $1"

    # create file name
    QUOTA="/tmp/"$TODAY"_buildAndDeploy_quota.txt"
    echo  "$TIME;$1;" >> $QUOTA

    # grep | wc -l on appname
    nb_line=`grep -c ";$1;" $QUOTA`

    # if res > quota exit -1 + error log
    if [ "$nb_line" -gt "$MAX_BUILD" ];then
        echo "ERROR: Max build number for the day exceeded: $MAX_BUILD"
        echo  "$TIME;$1;Rejected !" >> $QUOTA
        exit 1
    fi
    echo "INFO check quota: OK"
}


# log $file_name "INFO" "message"
# if LOGGER exists and is a valid filename print in it
# if LOG_MOD != stdout will log only in $LOGGER
# Else will print in stdout
function l_log {
    #$1 log level
    #$2 message
    if [ -f $LOGGER ];then
        if [ '$LOG_MOD' == 'stdout' ];then
            echo "[$( date '+%Y/%m/%d %H:%M:%S:%N')] $2 $3"  | tee -a $LOGGER
        else
            echo "[$( date '+%Y/%m/%d %H:%M:%S:%N')] $2 $3" > $LOGGER
        fi
    else
        echo "[$( date '+%Y/%m/%d %H:%M:%S:%N')] $2 $3"
    fi
}

function l_execute {
    CMD=$1

    echo "INFO Executing: "$CMD
    result=`$CMD`

    if [ $? -eq 0 ];then
        echo "INFO Success"
        echo $result
    else
        echo "ERROR executing: $CMD"
        echo $result
        exit 1
    fi
}


