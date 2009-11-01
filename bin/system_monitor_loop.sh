#!/bin/sh

# CONFIG HERE
RAILS_ENV='development'
DELAY=300


# INITIALIZE
WORKING_PATH=`pwd`
[ "$1" == "" ] || WORKING_PATH="$1"
[ "$2" == "-e" ] && RAILS_ENV="$3"
export RAILS_ENV


# MAIN LOOP
while :
do
    echo "RUNNING rake monitor IN MODE $RAILS_ENV"
    if [ -d $WORKING_PATH ]
    then
      cd $WORKING_PATH
        rake monitor:remote
      cd -
    else
    	echo "DIRECTORY $1 NOT FOUND. Usage: $0 working_directory [-e environment]"
    fi

    sleep $DELAY
done
