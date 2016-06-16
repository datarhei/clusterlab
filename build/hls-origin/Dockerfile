FROM datarhei/restreamer-edge:latest

RUN apt-get update && \
    apt-get install -y dnsutils

RUN mkdir /usr/local/nginx/html/snapshot && \
    chmod 777 /usr/local/nginx/html/snapshot

ADD snapshot.sh /snapshot.sh
RUN chmod +x /snapshot.sh && \
    chmod 777 /snapshot.sh

WORKDIR /

ADD run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/run.sh"]