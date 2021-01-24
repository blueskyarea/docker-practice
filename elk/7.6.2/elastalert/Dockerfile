FROM bitsensor/elastalert:3.0.0-beta.1

USER root

RUN apk update && \
    apk add bash curl && \
    rm -rf /var/cache/apk/*

ADD elastalert/bin/elastalert-start.sh /usr/local/bin/
ADD elastalert/bin/elastic_search_status.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/elastalert-start.sh 

USER node

ENTRYPOINT ["/usr/local/bin/elastalert-start.sh"]
