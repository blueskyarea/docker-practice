FROM alpine:3.10
LABEL maintainer "blueskyarea"

ARG ZOOKEEPER_VERSION=3.4.13
ARG ZK_TAR=zookeeper-${ZOOKEEPER_VERSION}.tar.gz
ENV PATH $PATH:/zookeeper/bin

LABEL Description="ZooKeeper" \
      "ZooKeeper Version"="$ZOOKEEPER_VERSION"

WORKDIR /

RUN set -eux && \
  apk add --no-cache curl wget tar bash openjdk8-jre

RUN set -eux && \
  url="http://www.apache.org/dyn/closer.lua?filename=zookeeper/zookeeper-${ZOOKEEPER_VERSION}/${ZK_TAR}&action=download" && \
  url_archive="http://archive.apache.org/dist/zookeeper/zookeeper-${ZOOKEEPER_VERSION}/${ZK_TAR}" && \
  wget -t 5 --retry-connrefused -O "$ZK_TAR" "$url" || \
  wget -t 5 --retry-connrefused -O "$ZK_TAR" "$url_archive" && \
  tar zxf "${ZK_TAR}" && \
  rm -fv "${ZK_TAR}" && \
  ln -sv /zookeeper-${ZOOKEEPER_VERSION} /zookeeper && \
  cp -av /zookeeper/conf/zoo_sample.cfg /zookeeper/conf/zoo.cfg

EXPOSE 2181 3181 4181

COPY zookeeper/bin/entrypoint.sh /
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]
