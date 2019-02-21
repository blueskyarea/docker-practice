##### Start
sudo docker-compose -f docker-compose.yml up -d

##### Access web console
http://localhost:8080

##### Your dag path
./dags/

##### Stop
sudo docker stop $(sudo docker ps -q)

