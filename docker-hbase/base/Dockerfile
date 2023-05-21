FROM alpine:3.10
LABEL maintainer "blueskyarea"

#ARG HBASE_VERSION=2.3.0
ARG HBASE_VERSION=2.1.3

ENV PATH $PATH:/hbase/bin

LABEL Description="HBase" \
  "HBase Version"="$HBASE_VERSION"

WORKDIR /

# Following command to install tools
RUN apk add --no-cache curl wget tar bash openjdk8-jre libc6-compat

RUN set -x && \
  url="http://www.apache.org/dyn/closer.lua?filename=hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz&action=download"; \
  url_archive="http://archive.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz"; \
  wget -t 10 --max-redirect 1 --retry-connrefused -O "hbase-$HBASE_VERSION-bin.tar.gz" "$url" || \
  wget -t 10 --max-redirect 1 --retry-connrefused -O "hbase-$HBASE_VERSION-bin.tar.gz" "$url_archive" && \
  mkdir "hbase-$HBASE_VERSION" && \
  tar zxf "hbase-$HBASE_VERSION-bin.tar.gz" -C "hbase-$HBASE_VERSION" --strip 1 && \
  test -d "hbase-$HBASE_VERSION" && \
  ln -sv "hbase-$HBASE_VERSION" hbase && \
  rm -fv "hbase-$HBASE_VERSION-bin.tar.gz" && \
  mkdir /hbase-data

RUN bash -c 'set -euxo pipefail && \
  echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
  apk add --no-cache jruby jruby-irb asciidoctor && \
  export JAVA_HOME=/usr && \
  echo exit | /hbase/bin/hbase shell \
'

VOLUME /hbase-data

COPY base/bin/entrypoint.sh /
COPY base/conf/hbase-site.xml /hbase/conf/
COPY base/profile.d/java.sh /etc/profile.d/

# REST      8080  / 8085
# Thrift    9090  / 9095
# HMaster   16000 / 16010
# RS        16201 / 16301
EXPOSE 2181 8080 8085 9090 9095 16000 16010 16030 16201 16301

RUN chmod +x /entrypoint.sh
RUN chmod +x /etc/profile.d/java.sh
ENV JAVA_HOME=/usr
ENTRYPOINT ["/entrypoint.sh"]
