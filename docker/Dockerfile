FROM ubuntu:20.04

ARG CTNG_UID=1000
ARG CTNG_GID=1000
RUN groupadd -g $CTNG_GID ctng
RUN useradd -d /home/ctng -m -g $CTNG_GID -u $CTNG_UID -s /bin/bash ctng

# Non-interactive configuration of tzdata
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
RUN { echo 'tzdata tzdata/Areas select Etc'; echo 'tzdata tzdata/Zones/Etc select UTC'; } | debconf-set-selections

RUN apt-get update
RUN apt-get install -y gcc g++ gperf bison flex texinfo help2man make libncurses5-dev \
    python3-dev autoconf automake libtool libtool-bin gawk wget bzip2 xz-utils unzip \
    patch libstdc++6 rsync git meson ninja-build
RUN wget -O /sbin/dumb-init https://github.com/Yelp/dumb-init/releases/download/v1.2.5/dumb-init_1.2.5_x86_64
RUN chmod a+x /sbin/dumb-init
RUN echo 'export PATH=/opt/ctng/bin:$PATH' >> /etc/profile

WORKDIR	/root

# Install dependencies.
RUN	apt-get update && DEBIAN_FRONTEND=noninteractive\
	apt-get install -y build-essential gperf bison flex texinfo wget gawk libtool automake libncurses5-dev help2man\
		ca-certificates

# Download and compile crosstool-NG.
RUN	wget http://crosstool-ng.org/download/crosstool-ng/crosstool-ng-1.25.0.tar.xz 2>&1 &&\
	tar xf crosstool-ng-*.tar* &&\
	cd crosstool-ng-1.25.0 &&\
	./configure --prefix /usr/local && make && make install &&\
	rm -rf ../crosstool-ng*

# Toolchain Building
# COPY .config  /toolchain/
# WORKDIR /toolchain
# RUN ct-ng build
# RUN ct-ng clean
# ENV PATH="${PATH}:/toolchain/aarch64-unknown-linux-gnu/bin"

# User Workspace
WORKDIR /workspace
ENTRYPOINT [ "/sbin/dumb-init", "--" ]
