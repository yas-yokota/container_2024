#!/usr/bin/bash


mkdir -p /var/tmp/dummyRoot 
cd /var/tmp/dummyRoot

tar chf - /bin/bash /lib/x86_64-linux-gnu/libtinfo.so.6 /lib/x86_64-linux-gnu/libc.so.6 /lib64/ld-linux-x86-64.so.2 | (cd /var/tmp/dummyRoot; tar xf - )
