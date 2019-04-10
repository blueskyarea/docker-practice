#!/bin/bash

# start mysql
/etc/init.d/mysqld start

# init mysql password
INIT_MYSQL_PASSWORD=$(grep 'A temporary password is generated for' /var/log/mysqld.log | sed -e "s/.*root@localhost: //")
NEW_MYSQL_PASSWORD="passPASS#7"
mysql -u root -p${INIT_MYSQL_PASSWORD} --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${NEW_MYSQL_PASSWORD}'; FLUSH PRIVILEGES;"
mysql -u root -p${NEW_MYSQL_PASSWORD} --connect-expired-password -e "CREATE DATABASE airflow;"
mysql -u root -p${NEW_MYSQL_PASSWORD} --connect-expired-password -e "CREATE USER airflow@localhost IDENTIFIED BY '${NEW_MYSQL_PASSWORD}';"
mysql -u root -p${NEW_MYSQL_PASSWORD} --connect-expired-password -e "GRANT ALL PRIVILEGES ON *.* TO airflow@localhost IDENTIFIED BY '${NEW_MYSQL_PASSWORD}' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# init airflow db
airflow initdb

# start airflow webserver
airflow webserver -p 8080 -D --stdout=/usr/local/airflow/logs/webserver-stdout.log --stderr=/usr/local/airflow/logs/webserver-stderr.log & 

# start airflow scheduler
airflow scheduler -D --stdout=/usr/local/airflow/logs/stdout.log --stderr=/usr/local/airflow/logs/stderr.log & 

# start airflow workder
export C_FORCE_ROOT='true' && airflow worker

