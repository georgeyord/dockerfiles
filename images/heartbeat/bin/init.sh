#!/bin/bash

################################
########## CURL FILES ##########
################################

SCRIPTS_PATH=/scripts

if [ "$(ls -A $SCRIPTS_PATH)" = "" ] ; then 
    echo "'$SCRIPTS_PATH' directory is empty, should contain files with cURL commands"
	exit 1;
fi

################################
####### HEARTBEAT_CYCLE ########
################################

echo "HEARTBEAT_CYCLE set: $HEARTBEAT_CYCLE"

################################
############ LOOP ##############
################################

while :
do
	for FILE in `ls $SCRIPTS_PATH`; do
	  	echo "Running $f file..."
		cat $SCRIPTS_PATH/$FILE
		eval $(cat $SCRIPTS_PATH/$FILE)
		echo ""
	done
	echo "Sleep for ${HEARTBEAT_CYCLE}seconds... Press [CTRL+C] to stop.."
	sleep $HEARTBEAT_CYCLE
done