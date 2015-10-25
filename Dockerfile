FROM ubuntu:14.04

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

# Install some usefull package
RUN apt-get update && \
    apt-get install -y python-software-properties software-properties-common &&\
    update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales
RUN add-apt-repository -y ppa:gluster/glusterfs-3.5 && \
    apt-get update && \
    apt-get install -y supervisor glusterfs-client curl unzip pwgen inotify-tools


# Add logrotate setting
ADD assets/setup/logrotate-supervisor.conf /etc/logrotate.d/supervisord

# Add supervisor setting
ADD assets/setup/supervisor-cron.conf /etc/supervisor/conf.d/cron.conf




# CLEAN APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

