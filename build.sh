#!/bin/bash
TAG=1.10

# Build
docker build --build-arg="HTML_CONTENT=app1-$TAG" -t argo:$TAG ./image/

# Old Images remove
# docker exec -it kind-worker 'crictl rmi $(crictl images | grep -E "import|argo" | awk "{print $3}")'

# TESTING
docker run -it --rm -d --name argo -p 5846:80 argo:$TAG
sleep 0.1
curl localhost:5846
docker rm --force argo
kind load docker-image argo:$TAG
docker rmi argo:$TAG

# Update charts
sed -i 's/1\../'$TAG'/' helm/values.yaml
sed -i 's/1\..\../1.'$TAG'/' helm/Chart.yaml

