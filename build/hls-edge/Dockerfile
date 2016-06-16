FROM vlipco/srv-router:latest

RUN curl -o /usr/local/openresty/lualib/resty/http_headers.lua https://raw.githubusercontent.com/pintsized/lua-resty-http/master/lib/resty/http_headers.lua && \
    curl -o /usr/local/openresty/lualib/resty/http.lua https://raw.githubusercontent.com/pintsized/lua-resty-http/master/lib/resty/http.lua && \
    curl -o /usr/local/openresty/lualib/resty/prometheus.lua https://raw.githubusercontent.com/knyar/nginx-lua-prometheus/master/prometheus.lua && \
    mkdir /usr/local/openresty/lualib/modfin/
ADD srv_proxy.lua /usr/local/openresty/lualib/modfin/srv_proxy.lua

RUN yum install git -y && \
    cd /tmp && git clone https://github.com/clappr/clappr
    
ADD player.html /tmp/player.html

ADD run.sh /run.sh
RUN chmod +x /run.sh

ENV SRV_RESOLVERS "198.51.100.1 198.51.100.2 198.51.100.3"

CMD ["/run.sh"]