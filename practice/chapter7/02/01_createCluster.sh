#!/bin/bash

AWS_PAGER=""
export AWS_PAGER


echo "$0.start"

echo ${LOGNAME} | /usr/bin/grep -E "^guest[[:digit:]]{2}$" > /dev/null 2>&1
RET=$?
if [[ ${RET} -ne 0 ]]; then
	echo "$0:invalid LOGNAME"
	echo "$0:___________FATAL : 講師に連絡を！"
	exit 1
fi

/usr/bin/envsubst < seed.conf > env.conf
. ./env.conf

/usr/local/bin/aws ecs create-cluster --cluster-name ${ClusterName} --region us-west-2
RET=$?
if [[ ${RET} -ne 0 ]]; then
	echo "$0:aws ecs create-cluster:fail"
	echo "$0:___________FATAL : 講師に連絡を！"
	exit 1
fi

echo "$0.success"
exit 0
