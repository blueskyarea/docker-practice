FROM docker.elastic.co/beats/filebeat:7.6.2
LABEL maintainer blueskyarea

COPY config/filebeat.docker.yml /usr/share/filebeat/filebeat.yml
USER root
RUN chown root:filebeat /usr/share/filebeat/filebeat.yml
USER filebeat
