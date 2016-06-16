#!/bin/bash

echo "HLS_ORIGIN_CPUS=${HLS_ORIGIN_CPUS}" > /tmp/pipeline-env.conf
echo "HLS_ORIGIN_MEM=${HLS_ORIGIN_MEM}" >> /tmp/pipeline-env.conf
echo "RTMP_TRANSCODER_CPUS=${RTMP_TRANSCODER_CPUS}" >> /tmp/pipeline-env.conf
echo "RTMP_TRANSCODER_MEM=${RTMP_TRANSCODER_MEM}" >> /tmp/pipeline-env.conf

DISPATCHER_PORT=$(dig srv _dispatcher.datarhei._tcp.marathon.mesos +short | awk '{print $3}')
curl --silent dispatcher.datarhei.marathon.mesos:$DISPATCHER_PORT/rtmp_origin.conf -o /nginx.conf
/usr/local/nginx/sbin/nginx -c /nginx.conf