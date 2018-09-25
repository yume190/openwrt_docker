# DOCKER-VERSION 1.0.0

FROM ubuntu:xenial
MAINTAINER yume190 <yume190@gmail.com>

RUN apt-get update -y && \
    apt-get install -y python python2.7 perl imagemagick subversion git gcc g++ binutils autoconf automake libtool-bin make bzip2 libncurses5-dev libreadline-dev zlib1g-dev flex bison patch texinfo tofrodos gettext pkg-config libstring-crc32-perl gawk libusb-dev unzip intltool libacl1-dev libcap-dev libc6-dev libglib2.0-dev unzip wget curl zip libssl-dev libxml-parser-perl file nano cmake time && \
    apt-get clean -y
    
# openwrt can't build with root user
RUN useradd -m -d /home/yume yume && \
    usermod -a -G root yume
USER yume
WORKDIR /home/yume

RUN git clone https://github.com/openwrt/openwrt.git && \
    cd openwrt && \
    git checkout v18.06.1 && \
    cp feeds.conf.default feeds.conf && \
    echo src-git linkit https://github.com/MediaTek-Labs/linkit-smart-7688-feed.git >> feeds.conf && \
    ./scripts/feeds update && \
    ./scripts/feeds install -a && \
    cd -

# make prereq
# make menuconfig

# Target System: Ralink RT288x/RT3xxx
#   MediaTek Ralink MIPS
# Subtarget: MT7688 based boards
#   MT76x8 based boards
# Target Profile: LinkIt7688
#   MediaTek LinkIt Smart 7688

# make -j4 # V=s