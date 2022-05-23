#!/bin/bash

AWS_PAGER=""
export AWS_PAGER


echo ${LOGNAME} | /usr/bin/grep -E "^guest[[:digit:]]{2}$" > /dev/null 2>&1
RET=$?
if [[ ${RET} -ne 0 ]]; then
	echo "$0:invalid LOGNAME"
	echo "$0:___________FATAL : 講師に連絡を！"
	exit 1
fi
. ./env.conf

TaskArn=$(/usr/local/bin/aws ecs list-tasks --cluster ${ClusterName} | /usr/bin/jq -r '.taskArns[]')

for i in ${TaskArn}
do
 /usr/local/bin/aws ecs describe-tasks --cluster ${ClusterName} --tasks ${i} |/usr/bin/jq -r '.tasks[].attachments[].details[]|select(.name == "privateIPv4Address").value'
 RET=$?
 if [[ ${RET} -ne 0 ]]; then
    echo "$0:aws ecs describe-tasks:fail"
 fi
done

exit 0
