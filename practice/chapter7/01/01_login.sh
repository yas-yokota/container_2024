#!/bin/bash

echo "$0.start"

/usr/local/bin/aws ecr get-login-password --region us-west-2 | /usr/bin/docker login --username AWS --password-stdin 373609171710.dkr.ecr.ap-northeast-1.amazonaws.com
RET=$?
if [[ ${RET} -ne 0 ]]; then
	echo "$0:___________FATAL : 講師に連絡を！"
	exit 1
fi

echo "$0.success"
exit 0
