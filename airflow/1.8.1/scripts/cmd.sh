#!/bin/bash

# start mysql
/etc/init.d/mysqld start

# init mysql password
INIT_MYSQL_PASSWORD=$(grep 'A temporary password is generated for' /var/log/mysqld.log | sed -e "s/.*root@localhost: //")
NEW_MYSQL_PASSWORD="passPASS@7"
mysql -u root -p${INIT_MYSQL_PASSWORD} --connect-expired-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${NEW_MYSQL_PASSWORD}'; flush privileges;"
mysql -u root -p${NEW_MYSQL_PASSWORD} --connect-expired-password -e "CREATE DATABASE airflow;"
mysql -u root -p${NEW_MYSQL_PASSWORD} --connect-expired-password -e "CREATE USER airflow@localhost IDENTIFIED BY '${NEW_MYSQL_PASSWORD}';"
mysql -u root -p${NEW_MYSQL_PASSWORD} --connect-expired-password -e "GRANT ALL privileges ON *.* to airflow@localhost with grant option; flush privileges;"

# init airflow db
airflow initdb

# start airflow webserver
airflow webserver -p 8080

# start airflow scheduler
airflow scheduler

