#!/bin/bash



function checkVariable() {
    echo ${LOGNAME} | /usr/bin/grep -E "^guest[[:digit:]]{2}$" > /dev/null 2>&1
    Ret=$?
    return ${Ret}
}


function getTags() { 
    Tags=$(/usr/local/bin/aws ecr list-images --repository-name ${LOGNAME}img | /usr/bin/jq -r '.imageIds[].imageDigest' | /usr/bin/sort -u )
}

function checkRepo() {
	/usr/local/bin/aws ecr describe-repositories --repository-names ${RegName} >/dev/null 2>&1
	Ret=$?
}


function deleteImage() {
    /usr/local/bin/aws ecr batch-delete-image --repository-name ${RegName} --image-ids imageDigest=$1
    RET=$?
    if [[ ${Ret} -ne 0 ]]; then
        return ${Ret}
    fi
}

function deleteRepo() {
    /usr/local/bin/aws ecr delete-repository --repository-name ${RegName}
    RET=$?
    if [[ ${Ret} -ne 0 ]]; then
        return ${Ret}
    fi
}


### MAIN
checkVariable
if [[ ${Ret} -ne 0 ]]; then
	echo "$0:invalid LOGNAME"
fi
RegName=${LOGNAME}img

getTags 2>/dev/null
if [[ "z${Tags}z" != zz ]]; then
 for i in "${Tags}"
 do
    deleteImage ${i}
    if [[ ${Ret} -ne 0 ]]; then
        echo "$0:aws ecr batch-delete-image.fail"
    fi
 done
fi

checkRepo
if [[ ${Ret} -eq 0 ]]; then
 deleteRepo
 if [[ ${Ret} -ne 0 ]]; then
	echo "$0:aws ecr delete-repositry.fail"
 fi
fi

exit 0
