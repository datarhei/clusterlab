#!/bin/bash
while true
do
  ffmpeg -i rtmp://127.0.0.1:$1/live/$2 -vframes 1 -y /usr/local/nginx/html/snapshot/$2.jpg
  sleep $3
done