#!/bin/sh

# run build container
echo "build.start"
docker run --rm -d -v $(pwd):/usr/src/myapp -e CGO_ENABLED=0 -w /usr/src/myapp golang:alpine3.15 go build -ldflags="-s -w -extldflags \"-static\""

# wait 
i=1
while [ ${i} -lt 10 ] && [ ! -f ./app  ]
do
    echo ${i}:waiting for build completed...
    i=$(expr $i + 1)
    sleep 5
done

# check
if [ ! -f ./app ]; then
    echo "build.failed"
    exit 1
fi

sudo strip app
echo "build.success"
exit 0
