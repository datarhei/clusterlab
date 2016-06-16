FROM datarhei/restreamer-edge:latest

RUN apt-get update && \
    apt-get install -y dnsutils

ADD pipeline.sh /pipeline.sh
ADD run.sh /run.sh
RUN chmod +x /pipeline.sh && chmod 777 /pipeline.sh
RUN chmod +x /run.sh

WORKDIR /

ENV HLS_ORIGIN_CPUS 0.1
ENV HLS_ORIGIN_MEM 128
ENV RTMP_TRANSCODER_CPUS 0.1
ENV RTMP_TRANSCODER_MEM 128

CMD ["/run.sh"]