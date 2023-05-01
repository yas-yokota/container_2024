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
. ./env.conf

Num=$( /usr/local/bin/aws ecs describe-services --cluster ${ClusterName} --services ${ServiceName} | /usr/bin/jq -r '.services[].desiredCount'  )
if [[ ${Num} -ne 0 ]]; then
 /usr/local/bin/aws ecs update-service --cluster ${ClusterName} --service ${ServiceName}  --desired-count 0
 RET=$?
 if [[ ${RET} -ne 0 ]]; then
    echo "$0:aws ecs update-service:fail"
 fi
fi

/usr/local/bin/aws ecs delete-service --cluster ${ClusterName} --service ${ServiceName} 
RET=$?
if [[ ${RET} -ne 0 ]]; then
	echo "$0:aws ecs delete-service:fail"
fi

Num=1
while [[ ${Num} -ne 0 ]]
do
    /usr/bin/sleep 3
    Num=$(/usr/local/bin/aws ecs describe-clusters --clusters ${ClusterName} | /usr/bin/jq -r '.clusters[].runningTasksCount')
done

/usr/local/bin/aws ecs delete-cluster --cluster ${ClusterName} 
RET=$?
if [[ ${RET} -ne 0 ]]; then
	echo "$0:aws ecs create-service:fail"
fi

for i in {1..9}
do
    aws ecs deregister-task-definition --task-definition ${TaskName}:${i}
done

echo "$0.success"
exit 0
