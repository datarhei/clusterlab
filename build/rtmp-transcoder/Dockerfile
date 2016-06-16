FROM datarhei/restreamer:latest

RUN apt-get update && \
    apt-get install -y dnsutils

ADD wrapper.sh /wrapper.sh
RUN chmod +x /wrapper.sh

CMD ["/wrapper.sh"]