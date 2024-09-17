**Build, tag and push to a registry**

```bash
# Docker Hub Login
docker login

# Create and tag Docker-Image
ORG=<Your organisation name at Docker Hub>
TAG=$(git describe --tags --long | sed -e 's/-g[0-9a-f]\{7,\}$//' -e 's/-\([0-9]\+\)$/.\1/')
docker build --build-arg VERSION=$TAG -t $ORG/debian-tuxbox-base:$TAG -t $ORG/debian-tuxbox-base:latest .

# Push Images to Docker Hub
docker push $ORG/debian-tuxbox-base:$TAG && docker push $ORG/debian-tuxbox-base:latest
```
