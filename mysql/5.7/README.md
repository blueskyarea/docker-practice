

# start container
docker run -d blueskyareahm/mysql-practice:5.7

# login container
docker exec -it [CONTAINER_NAME] /bin/bash

# login mysql
mysql -p blueskyarea

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

