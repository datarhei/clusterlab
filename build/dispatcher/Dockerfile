FROM datarhei/restreamer-edge:latest

ADD nginx.conf /nginx.conf
ADD configs /usr/local/nginx/html

WORKDIR /

ADD run.sh /run.sh
RUN chmod +x /run.sh

ENV HLS_ORIGIN_CPUS 0.1
ENV HLS_ORIGIN_MEM 128
ENV RTMP_TRANSCODER_CPUS 0.1
ENV RTMP_TRANSCODER_MEM 128

CMD ["/run.sh"]