#!/bin/sh
# useage: ./watch_fd.sh <application_id> [delay_sec = 1]

APPID=${1:?PackegeName missing}
DELAY=$(( ${2:-1} ))

CLEAR='\033[0m'
YELLOW='\033[33m'
RED='\033[31m'
GREEN='\033[32m'

FD_LIMIT=$(( $(adb shell ulimit -n) ))
WARN_THRESHOLD=$(( ${FD_LIMIT} / 2 ))
ERROR_THRESHOLD=$(( ${FD_LIMIT} / 3 * 2 ))
echo -e "FD_LIMIT ${FD_LIMIT}, WILL WARN WHEN FD > ${YELLOW}${WARN_THRESHOLD}${CLEAR} ADN FD > ${RED}${ERROR_THRESHOLD}${CLEAR}"

APP_PID=$(( $(adb shell ps | grep -e "${APPID}$" | awk '{print $2}') ))

while true; 
do
	APP_FD=$(( $(adb shell run-as ${APPID} ls -l /proc/${APP_PID}/fd | wc -l) ))
	if [ $APP_FD -ge $WARN_THRESHOLD ]
	then
		echo -e "Watching App ${YELLOW}${APPID}<${APP_PID}>${CLEAR}, Current FD ${YELLOW}${APP_FD}${CLEAR}. Press CTRL+C to stop."
	elif [ $APP_FD -ge $ERROR_THRESHOLD ]
	then
		echo -e "Watching App ${RED}${APPID}<${APP_PID}>${CLEAR}, Current FD ${RED}${APP_FD}${CLEAR}. Press CTRL+C to stop."
	else
		echo -e "Watching App ${GREEN}${APPID}<${APP_PID}>${CLEAR}, Current FD ${GREEN}${APP_FD}${CLEAR}. Press CTRL+C to stop."
	fi
	sleep $DELAY
done




