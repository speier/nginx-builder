FROM debian:wheezy

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    apt-get install -y curl build-essential \
    libpcre3-dev libssl-dev zlib1g-dev libgeoip-dev

ENV NGINX_VERSION 1.7.10
RUN curl http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz | tar -zx -C tmp
WORKDIR tmp/nginx-$NGINX_VERSION

RUN ./configure \
    --with-ipv6 \
    --with-pcre-jit \
		--with-http_dav_module \
		--with-http_ssl_module \
    --with-http_stub_status_module \
		--with-http_gzip_static_module \
		--with-http_spdy_module \
    --with-http_geoip_module

RUN make && make install

CMD ["cp", "/usr/local/nginx/sbin/nginx", "/output/nginx"]
