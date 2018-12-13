#!/bin/bash

# start mysql server
/etc/init.d/mysqld start

# create database;
/usr/bin/mysql -e "CREATE DATABASE p_learning;"

# use database;
/usr/bin/mysql -e "use p_learning;"

# create table
/usr/bin/mysql p_learning < /sqls/create_table.sql

# insert data
/usr/bin/mysql p_learning < /sqls/insert_data.sql

