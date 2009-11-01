#!/bin/sh
RAILS_ENV='development'
WORKING_PATH=`pwd`
[ "$1" == "" ] || WORKING_PATH="$1"
[ "$2" == "-e" ] && RAILS_ENV="$3"
export RAILS_ENV



echo "RUNNING rake monitor IN MODE $RAILS_ENV"
if [ -d $WORKING_PATH ]
then
  cd $WORKING_PATH
    rake monitor:remote
  cd -
else
	echo "DIRECTORY $1 NOT FOUND. Usage: $0 working_directory [-e environment]"
fi