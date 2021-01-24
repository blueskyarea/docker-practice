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
or
docker-compose -f docker-compose.dev.yml up --build -d
```

## Stop
```
docker stop $(docker ps -q)
```

