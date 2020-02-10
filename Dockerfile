FROM ubuntu:18.04

# ARGS
ARG userid
ARG groupid
ARG username

# SET NONINTERACTIVE
ENV DEBIAN_FRONTEND "noninteractive"

# RUN STUFF AS ROOT
USER root

RUN apt update && \
    apt install -y \
    apt-transport-https \
    aptitude \
    bsdmainutils \
    coreutils \
    curl \
    gpg \
    less \
    locales \
    locate \
    nano \
    net-tools \
    netcat-openbsd \
    tree \
    wget \
    sudo

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US
ENV LC_ALL en_US.UTF-8

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

RUN apt update \
    && apt install -y \
    libx11-xcb-dev \
    pkg-config \
    xdg-utils \
    dbus-x11 \
    git

RUN mkdir -p /var/run/dbus

RUN mkdir -p /home/$username \
    && echo "$username:x:$userid:$groupid:$username,,,:/home/$username:/bin/bash" >> /etc/passwd \
    && echo "$username:x:$userid:" >> /etc/group \
    && mkdir -p /etc/sudoers.d \
    && echo "$username ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$username \
    && chmod 0440 /etc/sudoers.d/$username \
    && chown $userid:$groupid -R /home/$username \
    && chmod 777 -R /home/$username \
    && usermod -a -G $username www-data \
    && dbus-uuidgen > /var/lib/dbus/machine-id

RUN apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/*

# UNSET NONINTERACTIVE
ENV DEBIAN_FRONTEND ""

USER $username
ENV SHELL /bin/bash
ENV HOME /home/$username
WORKDIR /home/$username

RUN echo 'include "/usr/share/themes/Ambiant-MATE/gtk-2.0/gtkrc"' > /home/$username/.gtkrc-2.0
