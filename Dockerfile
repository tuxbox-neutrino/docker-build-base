# Use the official Debian 11 image as a base
FROM debian:bullseye-slim

# Install the required tools and packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    binutils \
    build-essential \
    bzip2 \
    chrpath \
    clisp \
    coreutils \
    cpio \
    cppcheck \
    curl \
    dbus-x11 \
    debianutils \
    default-jre \
    diffstat \
    diffutils \
    doxygen \
    file \
    gawk \
    gcc \
    gcc-multilib \
    git \
    git-core \
    git-gui \
    gitk \
    gnupg \
    less \
    iputils-ping \
    libc6 \
    libcapstone4 \
    libc-bin \
    libegl1-mesa \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    libsdl1.2debian \
    libsdl2-dev \
    libxml2-utils \
    lighttpd \
    linux-libc-dev \
    locales \
    locales-all aspell aspell-de \
    lz4 \
    make \
    nano \
    net-tools \
    ninja-build \
    openssh-server \
    passwd \
    procps \
    pylint3 \
    python \
    python3 \
    python3-git \
    python3-jinja2 \
    python3-pexpect \
    rsync \
    runit \
    sed \
    socat \
    subversion \
    sudo \
    texinfo \
    tree \
    unzip \
    util-linux \
    wget \
    x11-xserver-utils \
    zstd \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Some labels
LABEL maintainer="Thilo Graf <dbt@novatux.de>" \
      maintainer.org="tuxbox-neutrino" \
      maintainer.org.uri="https://tuxbox-neutrino.org" \
      org.opencontainers.image.description="Debian based" \
      org.opencontainers.image.vendor="tuxbox-neutrino"

