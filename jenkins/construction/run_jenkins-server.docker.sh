#/bin/bash
sudo docker run -it -p 8080:8080 -p 50000:50000 -h jenkins.docker --name jenkins.docker -v ~/jenkins_home:/var/jenkins_home -d jenkins-server /bin/bash
sudo docker exec jenkins.docker /usr/local/bin/jenkins.sh
#sudo docker run -it -p 8080:8080 -p 50000:50000 -h jenkins.docker --name jenkins.docker -d jenkins-server /bin/bash
