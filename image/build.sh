#!/bin/bash
TAG=1.1

docker build --build-arg="HTML_CONTENT=app1-$TAG" -t argo:$TAG . 

# TESTING
docker run -it --rm -d --name argo -p 5846:80 argo:$TAG
sleep 0.1
curl localhost:5846
docker rm --force argo
kind load docker-image argo:$TAG
docker rmi argo:$TAG
sed -i 's/1\../'$TAG'/' ../helm/values.yaml
sed -i 's/1\..\../1.'$TAG'/' ../helm/Chart.yaml