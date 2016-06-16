#!/bin/bash

# RTMP TRANSCODER
# TODO: GET STATIC FFMPEG

printf "[info] \n"
printf "[info] DISCOVER HLS_ORIGIN\n"

until [ "$HLS_ORIGIN_RTMP_PORT" != "" ]
do
    HLS_ORIGIN_RTMP_PORT=$(dig srv _$1.origin.hls.datarhei._tcp.marathon.mesos +short | awk '{print $3}' | sort | head -n1)
    sleep 1
done

printf "[info] HLS_ORIGIN_RTMP_PORT $HLS_ORIGIN_RTMP_PORT\n"

if [ "${FFMPEG_LOGLEVEL}" = "" ]
then
    export FFMPEG_LOGLEVEL=warning
fi

DISPATCHER_PORT=$(dig srv _dispatcher.datarhei._tcp.marathon.mesos +short | awk '{print $3}')
FFMPEG_PRESET=$(curl --silent dispatcher.datarhei.marathon.mesos:$DISPATCHER_PORT/rtmp_transcoder.conf)

printf "[info] \n"
printf "[info] START RTMP-TRANSCODER\n"
printf "[info] ENV FFMPEG_LOGLEVEL ${FFMPEG_LOGLEVEL}\n"

ffmpeg \
    -loglevel "${FFMPEG_LOGLEVEL}" \
    -i tcp://0.0.0.0:"$2"?listen \
    $FFMPEG_PRESET \
    -f flv rtmp://"$1".origin.hls.datarhei.marathon.mesos:"$HLS_ORIGIN_RTMP_PORT"/live/"$1"