FROM ubuntu:18.04

# SET NONINTERACTIVE
ENV DEBIAN_FRONTEND "noninteractive"

RUN apt update && \
    apt install -y \
    curl \
    gpg \
    coreutils \
    tree \
    nano \
    less \
    aptitude \
    net-tools \
    locate \
    bsdmainutils \
    netcat-openbsd \
    apt-transport-https

RUN apt update \
    && apt install -y \
    libnotify4 \
    libnss3 \
    libxkbfile1 \
    libgconf-2-4 \
    libsecret-1-0 \
    libgtk2.0-0 \
    libxss1 \
    libasound2 \
    libcanberra-gtk-module \
    gtk2-engines-murrine \
    gtk2-engines-pixbuf \
    ubuntu-mate-icon-themes \
    ubuntu-mate-themes

RUN apt install -y \
    libx11-xcb-dev \
    pkg-config \
    xdg-utils \
    dbus-x11

RUN apt install -y wget

RUN mkdir -p /var/run/dbus

RUN useradd -m andrei
ENV USER andrei
WORKDIR /home/andrei/

RUN echo "root:root" | chpasswd

RUN echo 'include "/usr/share/themes/Ambiant-MATE/gtk-2.0/gtkrc"' > /home/andrei/.gtkrc-2.0
