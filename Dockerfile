FROM ubuntu:16.04

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

# Install some usefull package
RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common &&\
    update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales
RUN apt-get update && \
    apt-get install -y supervisor curl unzip pwgen inotify-tools dnsutils vim git wget python-pip sudo logrotate

# Add Python API for rancher-metadata
RUN pip install rancher_metadata

# Add logrotate setting
ADD assets/setup/logrotate-supervisor.conf /etc/logrotate.d/supervisord

# Add supervisor setting
ADD assets/setup/supervisor-cron.conf /etc/supervisor/conf.d/cron.conf

# Add syslog group for logrotate
RUN groupadd syslog




# CLEAN APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
