FROM docker.elastic.co/beats/filebeat:7.8.1

COPY ./config/filebeat.yml /usr/share/filebeat/filebeat.yml
COPY ./config/elasticsearch.yml /usr/share/filebeat/modules.d/elasticsearch.yml

USER root
RUN chown root:filebeat /usr/share/filebeat/filebeat.yml
RUN chown root:filebeat /usr/share/filebeat/modules.d/elasticsearch.yml
USER filebeat
