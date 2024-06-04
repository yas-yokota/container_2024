#!/bin/bash

echo "$0.start"

echo ${LOGNAME} | /usr/bin/grep -E "^guest[[:digit:]]{2}$" > /dev/null 2>&1
RET=$?
if [[ ${RET} -ne 0 ]]; then
	echo "$0:invalid LOGNAME"
	echo "$0:___________FATAL : 講師に連絡を！"
	exit 1
fi
RegName=${LOGNAME}img

/usr/local/bin/aws ecr create-repository --repository-name ${RegName} --image-scanning-configuration scanOnPush=true --region us-west-2
RET=$?
if [[ ${RET} -ne 0 ]]; then
	echo "$0:aws ecr create-repositry.fail"
	echo "$0:___________FATAL : 講師に連絡を！"
	exit 1
fi

echo "$0.success"
exit 0
