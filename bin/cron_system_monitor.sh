#!/bin/sh

DIR=`dirname $0`/../

[ "$1" == "-e" ] && RAILS_ENV=$2
export RAILS_ENV

if [ -d $DIR ]
then
  echo "# EXECUTE system_monior_loop.sh AS $USER IN $DIR RAILS_ENV=$RAILS_ENV" >> /var/log/system_monitor.log
  START_CD=`pwd`
  cd $DIR
    bin/system_monitor_loop.sh $DIR -e $RAILS_ENV >> /var/log/system_monitor.log 2>&1
  cd $START_CD
else
  echo "# ERROR: DIRECTORY '$DIR' NOT EXISTS"
fi

