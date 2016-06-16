#!/bin/bash

curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" \
    marathon.mesos:8080/v2/apps  -d '{
  "id": "/datarhei/rtmp/origin",
  "cpus": 0.1,
  "mem": 128,
  "disk": 0,
  "instances": 1,
  "env": {
    "HLS_ORIGIN_CPUS": "'${HLS_ORIGIN_CPUS}'",
    "HLS_ORIGIN_MEM": "'${HLS_ORIGIN_MEM}'",
    "RTMP_TRANSCODER_CPUS": "'${RTMP_TRANSCODER_CPUS}'",
    "RTMP_TRANSCODER_MEM": "'${RTMP_TRANSCODER_MEM}'"
  },
  "container": {
    "type": "DOCKER",
    "volumes": [],
    "docker": {
      "image": "datarhei/clab-rtmp-origin:latest",
      "network": "BRIDGE",
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
      ],
      "forcePullImage": true
    }
  }
}'

curl -X POST -H "Accept: application/json" -H "Content-Type: application/json" \
    marathon.mesos:8080/v2/apps  -d '{
  "id": "/datarhei/hls/edge",
  "cpus": 0.1,
  "mem": 256,
  "disk": 0,
  "instances": 1,
  "container": {
    "type": "DOCKER",
    "volumes": [],
    "docker": {
      "image": "datarhei/clab-hls-edge:latest",
      "network": "BRIDGE",
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 0,
          "protocol": "tcp",
          "name": "http"
        }
      ],
      "forcePullImage": true
    }
  }
}'

/usr/local/nginx/sbin/nginx -c /nginx.conf