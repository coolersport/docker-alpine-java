FROM anapsix/alpine-java:8u162b12_server-jre_unlimited

MAINTAINER Tien Tran

ENV TZ Australia/Melbourne

COPY entrypoint.sh /

RUN addgroup alpine && adduser -S -D -G alpine alpine && \
    apk --no-cache add tzdata curl dpkg && \
    # install gosu
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" && \
    curl -fsSL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$dpkgArch" -o /usr/local/bin/gosu && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true && \
    # complete gosu
    chmod u+x entrypoint.sh && \
    apk del curl dpkg && \
    rm -rf /apk /tmp/* /var/cache/apk/*

ENTRYPOINT ["/entrypoint.sh"]
