# Use the official Debian 11 image as a base
FROM debian:bookworm-slim

ARG VERSION

# Install the required tools and packages
ENV STD_GCC_VERSION=14
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    aspell \
    aspell-de \
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
    g++ \
    gawk \
    gcc \
    gcc-multilib \
    git \
    git-core \
    git-filter-repo \
    git-gui \
    gitk \
    g++-multilib \
    gnupg \
    graphviz \
    iputils-ping \
    less \
    libacl1 \
    libbz2-dev \
    libc6 \
    libcapstone4 \
    libc-bin \
    libdb5.3-dev \
    libegl1-mesa \
    libexpat1-dev \
    libgdbm-dev \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    liblz4-tool \
    liblzma-dev \
    libncurses5-dev \
    libncursesw5-dev \
    libreadline-dev \
    libsdl1.2debian \
    libsdl2-dev \
    libsqlite3-dev \
    libssl-dev \
    libxml2-utils \
    lighttpd \
    linux-libc-dev \
    locales \
    locales-all \
    lz4 \
    make \
    nano \
    net-tools \
    ninja-build \
    openjdk-17-jdk \
    openssh-server \
    passwd \
    procps \
    pylint \
    python3 \
    python3-git \
    python3-jinja2 \
    python3-pexpect \
    python3-pip \
    python3-subunit \
    rsync \
    runit \
    sed \
    socat \
    sshpass \
    subversion \
    sudo \
    texinfo \
    tk-dev \
    tree \
    unzip \
    util-linux \
    wget \
    x11-xserver-utils \
    xz-utils \
    zip \
    zlib1g-dev \
    zstd

# Set the standard GCC version to install (replace STD_GCC_VERSION with the actual version)
ARG STD_GCC_VERSION=12

# Install the standard GCC and G++ versions
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${STD_GCC_VERSION} ${STD_GCC_VERSION} && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${STD_GCC_VERSION} ${STD_GCC_VERSION}

# Set environment variable for alternative GCC version
ENV ALT_GCC_VERSION=14

# Add testing repo and install GCC/G++ 14 with multilib
RUN echo "deb http://deb.debian.org/debian testing main" >> /etc/apt/sources.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    gcc-${ALT_GCC_VERSION} \
    g++-${ALT_GCC_VERSION} \
    gcc-${ALT_GCC_VERSION}-multilib \
    g++-${ALT_GCC_VERSION}-multilib

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${ALT_GCC_VERSION} ${ALT_GCC_VERSION} && \
    update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${ALT_GCC_VERSION} ${ALT_GCC_VERSION} && \
    update-alternatives --set gcc /usr/bin/gcc-${ALT_GCC_VERSION} && \
    update-alternatives --set g++ /usr/bin/g++-${ALT_GCC_VERSION}

RUN ln -sf /usr/bin/python3 /usr/bin/python

# Locales
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales && \
    echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
    echo "de_DE.UTF-8 UTF-8" >> /etc/locale.gen && \
    locale-gen
#
# Python 2.7
ENV ALT_PYTHON_VERSION=2.7.18-8+deb11u1
ENV MIME_SUPPORT_VERSION=3.66
RUN wget -nc https://ftp.debian.org/debian/pool/main/p/python2.7/libpython2.7-minimal_${ALT_PYTHON_VERSION}_amd64.deb && \
    wget -nc https://ftp.debian.org/debian/pool/main/o/openssl/libssl1.1_1.1.1w-0+deb11u1_amd64.deb && \
    wget -nc https://ftp.debian.org/debian/pool/main/libf/libffi/libffi7_3.3-6_amd64.deb  && \
    wget -nc https://ftp.debian.org/debian/pool/main/p/python2.7/python2.7-minimal_${ALT_PYTHON_VERSION}_amd64.deb && \
    wget -nc https://ftp.debian.org/debian/pool/main/p/python2.7/libpython2.7-stdlib_${ALT_PYTHON_VERSION}_amd64.deb && \
    wget -nc https://ftp.debian.org/debian/pool/main/m/mime-support/mime-support_${MIME_SUPPORT_VERSION}_all.deb && \
    wget -nc https://ftp.debian.org/debian/pool/main/p/python2.7/python2.7_${ALT_PYTHON_VERSION}_amd64.deb && \
    dpkg -i libpython2.7-minimal_${ALT_PYTHON_VERSION}_amd64.deb \
             libssl1.1_1.1.1w-0+deb11u1_amd64.deb \
             libffi7_3.3-6_amd64.deb \
             python2.7-minimal_${ALT_PYTHON_VERSION}_amd64.deb \
             libpython2.7-stdlib_${ALT_PYTHON_VERSION}_amd64.deb \
             mime-support_${MIME_SUPPORT_VERSION}_all.deb \
             python2.7_${ALT_PYTHON_VERSION}_amd64.deb; \
    apt-get update && \
    apt-get install -f -y && \
    rm -f libpython2.7-minimal_${ALT_PYTHON_VERSION}_amd64.deb \
          libssl1.1_1.1.1w-0+deb11u1_amd64.deb \
          libffi7_3.3-6_amd64.deb \
          python2.7-minimal_${ALT_PYTHON_VERSION}_amd64.deb \
          libpython2.7-stdlib_${ALT_PYTHON_VERSION}_amd64.deb \
          mime-support_${MIME_SUPPORT_VERSION}_all.deb \
          python2.7_${ALT_PYTHON_VERSION}_amd64.deb && \
    ln -sf /usr/bin/python2.7 /usr/bin/python2

# cleanup
RUN apt-get clean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/apt/archives/*

# Some labels
LABEL container.version=$VERSION \
      maintainer="Thilo Graf <dbt@novatux.de>" \
      maintainer.org="tuxbox-neutrino" \
      maintainer.org.uri="https://tuxbox-neutrino.org" \
      org.opencontainers.image.description="Debian based" \
      org.opencontainers.image.vendor="tuxbox-neutrino"
