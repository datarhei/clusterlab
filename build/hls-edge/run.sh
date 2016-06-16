#!/bin/bash

DISPATCHER_PORT=$(dig srv _dispatcher.datarhei._tcp.marathon.mesos +short | awk '{print $3}')
curl --silent dispatcher.datarhei.marathon.mesos:$DISPATCHER_PORT/hls_edge.conf -o /nginx.conf
nginx -c /nginx.conf