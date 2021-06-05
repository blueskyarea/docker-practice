FROM mysql:5.7
LABEL maintainer "blueskyarea"
 
ENV MYSQL_ROOT_PASSWORD=blueskyarea

COPY conf/my.cnf /etc/mysql/conf.d/my.cnf
COPY data/world.sql.gz /docker-entrypoint-initdb.d/world.sql.gz
