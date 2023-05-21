

# start container
docker run -d -p 3306:3306 blueskyareahm/mysql-practice:5.7

# login container
docker exec -it [CONTAINER_NAME] /bin/bash

# login mysql
mysql -pblueskyarea

# select database
mysql> use world;

# Sample select command
mysql> select * from city where Name = 'Tokyo';
+------+-------+-------------+----------+------------+
| ID   | Name  | CountryCode | District | Population |
+------+-------+-------------+----------+------------+
| 1532 | Tokyo | JPN         | Tokyo-to |    7980230 |
+------+-------+-------------+----------+------------+
1 row in set (0.01 sec)

# Backup MySQL database example
mysqldump --single-transaction -u root -pblueskyarea itstudy > itstudy_$(date +"%Y%m%d%H%M").sql

# Restore MySQL database example
mysql -h localhost -u root -pblueskyarea itstudy < file.sql

