#!/bin/bash

if [ "$2" = "online" ]
then
    source /tmp/pipeline-env.conf
    curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" \
      marathon.mesos:8080/v2/apps  -d '{
      "id": "/datarhei/hls/origin/'$1'",
      "cpus": '${HLS_ORIGIN_CPUS}',
      "mem": '${HLS_ORIGIN_MEM}',
      "disk": 0,
      "instances": 1,
      "container": {
        "type": "DOCKER",
        "volumes": [],
        "docker": {
          "image": "datarhei/clab-hls-origin:latest",
          "network": "BRIDGE",
          "forcePullImage": true,
          "portMappings": [
            {
              "containerPort": 1935,
              "hostPort": 0,
              "protocol": "tcp",
              "name": "rtmp"
            },
            {
              "containerPort": 80,
              "hostPort": 0,
              "protocol": "tcp",
              "name": "http"
            }
          ]
        }
      }
    }'
    curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" \
      marathon.mesos:8080/v2/apps  -d '{
      "id": "/datarhei/rtmp/transcoder/'$1'",
      "container": {
        "type": "DOCKER",
        "docker": {
          "image": "datarhei/clab-rtmp-transcoder:latest",
          "network": "HOST",
          "forcePullImage": true
        },
        "volumes" : []
      },
      "instances": 1,
      "cpus": '${RTMP_TRANSCODER_CPUS}',
      "mem": '${RTMP_TRANSCODER_MEM}',
      "cmd": "/wrapper.sh '$1' $PORT0"
    }'
    until [ "$RTMP_TRANSCODER_PORT" != "" ]
    do
        RTMP_TRANSCODER_PORT=$(dig srv _$1.transcoder.rtmp.datarhei._tcp.marathon.mesos +short | awk '{print $3}')
        sleep 1
    done
    while true
    do
      ffmpeg -i rtmp://127.0.0.1:1935/live/"$1" -c copy -f flv tcp://"$1".transcoder.rtmp.datarhei.marathon.mesos:"$RTMP_TRANSCODER_PORT"
      sleep 5
      RTMP_TRANSCODER_PORT=$(dig srv _$1.transcoder.rtmp.datarhei._tcp.marathon.mesos +short | awk '{print $3}')
    done
else
    curl -X DELETE -H "Accept: application/json" -H "Content-Type: application/json" marathon.mesos:8080/v2/apps/datarhei/rtmp/transcoder/$1
    curl -X DELETE -H "Accept: application/json" -H "Content-Type: application/json" marathon.mesos:8080/v2/apps/datarhei/hls/origin/$1
fi


