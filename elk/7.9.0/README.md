# docker-elk

## Preparation
To execute docker command without "sudo".
```
sudo groupadd docker
sudo usermod -g docker {your user name}
```

## Start
```
docker-compose up --build -d
```

## Stop
```
docker stop $(docker ps -q)
```

