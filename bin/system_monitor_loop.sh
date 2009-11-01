#!/bin/sh

# CONFIG HERE
DELAY=300


# INITIALIZE
WORKING_PATH=`pwd`
[ "$1" == "" ] || WORKING_PATH="$1"
[ "$2" == "-e" ] && RAILS_ENV="$3"
export RAILS_ENV


# MAIN LOOP
while :
do
    echo "`date "+%Y-%m-%d %H:%M:%S"` RUNNING rake monitor IN MODE $RAILS_ENV"
    if [ -d $WORKING_PATH ]
    then
      SAVE_WD=`pwd`
      rake monitor:remote
      cd $SAVE_WD
    else
    	echo "DIRECTORY $1 NOT FOUND. Usage: $0 working_directory [-e environment]"
    fi

    sleep $DELAY
done
