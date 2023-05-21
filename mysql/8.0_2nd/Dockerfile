FROM mysql:8.0.23

RUN mkdir /var/log/mysql
RUN chown mysql:mysql /var/log/mysql
COPY my.cnf /etc/mysql/conf.d/my.cnf
COPY ./init-sql /docker-entrypoint-initdb.d
