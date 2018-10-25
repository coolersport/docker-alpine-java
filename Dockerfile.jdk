FROM anapsix/alpine-java:8u191b12_jdk_unlimited

MAINTAINER Tien Tran

ENV TZ=Australia/Melbourne \
    STORE_PASS=changme \
    KEY_PASS=changme \
    WAITFOR_HOST= \
    WAITFOR_PORT= \
    TIMEOUT=120 \
    JAVA_VERSION_MAJOR=8 \
    JAVA_VERSION_MINOR=191 \
    JAVA_VERSION_BUILD=12 \
    DOWNLOAD_HASH=2787e4a523244c269598db4e85c51e0c

COPY entrypoint.sh /

RUN addgroup alpine && adduser -S -D -G alpine alpine && \
    apk --no-cache add tzdata curl dpkg openssl && \
    # install gosu
    dpkgArch="$(dpkg --print-architecture | awk -F- '{ print $NF }')" && \
    curl -fsSL "https://github.com/tianon/gosu/releases/download/1.10/gosu-$dpkgArch" -o /usr/local/bin/gosu && \
    chmod +x /usr/local/bin/gosu && \
    gosu nobody true && \
    # complete gosu
    chmod u+x entrypoint.sh && \
    ## re-adding jdk files
    curl -jkLH "Cookie: oraclelicense=accept-securebackup-cookie" -o /tmp/java.tar.gz \
      http://download.oracle.com/otn-pub/java/jdk/${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-b${JAVA_VERSION_BUILD}/${DOWNLOAD_HASH}/${JAVA_PACKAGE}-${JAVA_VERSION_MAJOR}u${JAVA_VERSION_MINOR}-linux-x64.tar.gz && \
    gunzip /tmp/java.tar.gz && \
    mkdir /tmp/jdk && tar -C /tmp/jdk -xf /tmp/java.tar && \
    cp /tmp/jdk/jdk1.${JAVA_VERSION_MAJOR}.0_${JAVA_VERSION_MINOR}/jre/lib/ext/nashorn.jar /opt/jdk/jre/lib/ext/ && \
    rm -rf /tmp/jdk && \
    ## finish adding jdk files
    apk del curl dpkg && \
    rm -rf /apk /tmp/* /var/cache/apk/*

ENTRYPOINT ["/entrypoint.sh"]
