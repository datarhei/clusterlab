#!/bin/bash

DISPATCHER_PORT=$(dig srv _dispatcher.datarhei._tcp.marathon.mesos +short | awk '{print $3}')
curl --silent dispatcher.datarhei.marathon.mesos:$DISPATCHER_PORT/hls_origin.conf -o /nginx.conf
/usr/local/nginx/sbin/nginx -c /nginx.conf