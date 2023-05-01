#!/usr/bin/bash


cd /var/tmp/dummyRoot

tar chf - /bin/ls /lib/x86_64-linux-gnu/libselinux.so.1 /lib/x86_64-linux-gnu/libc.so.6 /lib/x86_64-linux-gnu/libpcre2-8.so.0 /lib64/ld-linux-x86-64.so.2 | (cd /var/tmp/dummyRoot; tar xf - )
