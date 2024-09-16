# Use the official Debian 11 image as a base
FROM debian:bullseye-slim

ARG VERSION

# Install the required tools and packages
RUN apt-get update && apt-get install -y --no-install-recommends \
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
    zstd && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy additional apt config files
COPY root/etc/apt/sources.list.d/sid.list /etc/apt/sources.list.d/sid.list
COPY root/etc/apt/preferences.d/sid.pref /etc/apt/preferences.d/sid.pref

# Install gcc 13 and set gcc-13 as default and git-filter-repo
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc-13 \
    g++-13 \
    gcc-13-multilib \
    g++-13-multilib \
    git-filter-repo && \
    update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 60 && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-13 60 && \
    apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm /etc/apt/sources.list.d/sid.list && \
    rm /etc/apt/preferences.d/sid.pref

# Some labels
LABEL container.version=$VERSION \
      maintainer="Thilo Graf <dbt@novatux.de>" \
      maintainer.org="tuxbox-neutrino" \
      maintainer.org.uri="https://tuxbox-neutrino.org" \
      org.opencontainers.image.description="Debian based" \
      org.opencontainers.image.vendor="tuxbox-neutrino"
