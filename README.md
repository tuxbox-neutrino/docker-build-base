**Build Docker image**

```bash
TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "latest")
docker build -t debian-tuxbox-base:$TAG -t debian-tuxbox-base:latest .
```

**Build, tag and push to a registry**

```bash
#!/bin/bash

# Docker Hub Login
docker login

# Create and tag Docker-Image
ORG=<Your name of registry organisation>
TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "latest")
docker build -t $ORG/debian-tuxbox-base:$TAG -t $ORG/debian-tuxbox-base:latest .

# Push Images to Docker Hub
docker push $ORG/debian-tuxbox-base:$TAG
docker push $ORG/debian-tuxbox-base:latest
```
