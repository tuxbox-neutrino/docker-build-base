**Build Docker a image**

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
TAG=$(git describe --tags --abbrev=0 2>/dev/null || echo "latest")
docker build -t <org>/debian-tuxbox-base:$TAG -t <org>/debian-tuxbox-base:latest .

# Push Images to Docker Hub
docker push <org>/debian-tuxbox-base:$TAG
docker push <org>/debian-tuxbox-base:latest
```
