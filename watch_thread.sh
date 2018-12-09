#!/bin/sh
# useage: ./watch_thread.sh <application_id> [delay_sec = 1]

APPID=${1:?PackegeName missing}
DELAY=$(( ${2:-10} ))

CLEAR='\033[0m'
YELLOW='\033[33m'
RED='\033[31m'
GREEN='\033[32m'

APP_PID=$(( $(adb shell ps | grep -e "${APPID}$" | awk '{print $2}') ))
thread_array=( $(adb shell ps -t | grep $APP_PID | awk '{print  $9}') )
ori_len=${#thread_array[@]}
# 遍历
# for i in "${thread_array[@]}"
# do
# 	echo "${i}"
# done
echo -e  "Origin Total Thread: ${GREEN}${ori_len}${CLEAR}"

while true;
do
	sleep $DELAY

	
	temp_thread_array=( $(adb shell ps -t | grep $APP_PID | awk '{print  $9}') )

	echo '\n\n'
	echo -e "Org Total Thread: ${GREEN}${ori_len}${CLEAR}"
	echo -e "Crt Total Thread: ${YELLOW}${#temp_thread_array[@]}${CLEAR}"	
	# 1. 这个方法虽然省事，但效果不好
	# echo -e ${thread_array[@]} ${temp_thread_array[@]} | tr ' ' '\n' | sort | uniq -u

	# 2. 这个方法不但麻烦，还慢，但效果好点
	len=${#temp_thread_array[@]}
	for ((i=$len-1; i>=0; i--))
	do
		for ((j=$ori_len-1; j>=0; j--))
		do
			if [ ${temp_thread_array[$i]}x = ${thread_array[$j]}x ]
			then
				unset temp_thread_array[$i]
			fi 
		done
	done

	echo -e "${YELLOW}New Thread Name:"
	# 遍历新增的线程
	for k in "${temp_thread_array[@]}"
	do
		echo $k
	done

	echo -e "-------------------${CLEAR}"
	echo -e "Press CTRL+C To Stop."
done





