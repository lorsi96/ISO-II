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
WORKDIR /toolchain
RUN useradd -ms /bin/bash dockeruser && chown -R dockeruser /toolchain
USER dockeruser

COPY .config  /toolchain/
RUN ct-ng build
RUN ct-ng clean
ENV PATH="${PATH}:/toolchain/aarch64-unknown-linux-gnu/bin"

# U-Boot dependencies
USER root
RUN apt-get update && apt-get install -y \
	automake \
	autopoint \
	bc \
	binutils-dev \
	bison \
	build-essential \
	coreutils \
	cpio \
	cppcheck \
	curl \
	device-tree-compiler \
	dosfstools \
	e2fsprogs \
	efitools \
	erofs-utils \
	expect \
	fakeroot \
	flex \
	gawk \
	gdisk \
	git \
	gnu-efi \
	gnutls-dev \
	graphviz \
	grub-efi-amd64-bin \
	grub-efi-ia32-bin \
	help2man \
	iasl \
	imagemagick \
	iputils-ping \
	libconfuse-dev \
	libgit2-dev \
	libjson-glib-dev \
	libguestfs-tools \
	libgnutls28-dev \
	libgnutls30 \
	liblz4-tool \
	libpixman-1-dev \
	libpython3-dev \
	libsdl1.2-dev \
	libsdl2-dev \
	libseccomp-dev \
	libssl-dev \
	libtool \
	libudev-dev \
	libusb-1.0-0-dev \
	linux-image-kvm \
	lzma-alone \
	lzop \
	mount \
	mtd-utils \
	mtools \
	net-tools \
	ninja-build \
	openssl \
	picocom \
	parted \
	pkg-config \
	python-is-python3 \
	python2.7 \
	python3 \
	python3-dev \
	python3-pip \
	python3-sphinx \
	python3-virtualenv \
	rpm2cpio \
	sbsigntool \
	sloccount \
	socat \
	softhsm2 \
	sparse \
	srecord \
	sudo \
	swig \
	util-linux \
	uuid-dev \
	virtualenv \
	xxd \
	zip \
	&& rm -rf /var/lib/apt/lists/*

# ATF -- Needed by Uboot
WORKDIR /ATF
ENV CROSS_COMPILE=aarch64-unknown-linux-gnu-
ENV ARCH=arm
RUN git clone https://github.com/ARM-software/arm-trusted-firmware.git . && \
	make PLAT=sun50i_a64 DEBUG=1 bl31
ENV BL31=/ATF/build/sun50i_a64/debug/bl31.bin

# User Workspace
USER dockeruser
WORKDIR /workspace
ENTRYPOINT [ "/sbin/dumb-init", "--" ]
