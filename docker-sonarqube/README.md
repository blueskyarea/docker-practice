##### 1. Build docker image

```
docker build --tag={your_image_name}
```

start container
docker run -itd --name mysonar -p 9001:9000 blueskyareahm/sonarqube:8.6
