# Use the official Debian 11 image as a base
FROM debian:bullseye-slim

ARG VERSION

# Install the required tools and packages
RUN echo 'deb http://deb.debian.org/debian bullseye-backports main' > /etc/apt/sources.list.d/bullseye-backports.list && \
    DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    bash \
    binutils \
    build-essential \
    bzip2 \
    ccache \
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
    fakeroot \
    file \
    gcc \
    g++ \
    gcc-multilib \
    g++-multilib \
    git-filter-repo \
    gawk \
    graphviz \
    git \
    git-core \
    git-gui \
    gitk \
    gnupg \
    iputils-ping \
    less \
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
    locales-all \
    aspell \
    aspell-de \
    lz4 \
    make \
    nano \
    net-tools \
    ninja-build \
    openssh-server \
    openjdk-11-jdk \
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
    sshpass \
    subversion \
    sudo \
    texinfo \
    tree \
    unzip \
    util-linux \
    wget \
    x11-xserver-utils \
    zip \
    zstd

# cleanup
RUN apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Some labels
LABEL container.version=$VERSION \
      maintainer="Thilo Graf <dbt@novatux.de>" \
      maintainer.org="tuxbox-neutrino" \
      maintainer.org.uri="https://tuxbox-neutrino.org" \
      org.opencontainers.image.description="Debian based" \
      org.opencontainers.image.vendor="tuxbox-neutrino"
