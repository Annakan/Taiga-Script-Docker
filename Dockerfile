##############################################################
##
##
##  taiga from taiga-script 
##
##
###############################################################

#FROM ubuntu-x 
FROM phusion/baseimage:latest

MAINTAINER XK "local"

ENV SERVER_NAME localhost
ENV DEBIAN_FRONTEND noninteractive


# make the "en_US.UTF-8" locale
RUN sed -i "s|exit 101|exit 0|g" /usr/sbin/policy-rc.d
RUN apt-get update && apt-get install -y locales && rm -rf /var/lib/apt/lists/* && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN apt-get update

RUN echo "alias ll='ls -atrhlF'" >> ~/.bashrc


# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r taiga && useradd -m -g taiga taiga \
    && usermod -a -G sudo taiga


EXPOSE 80

RUN apt-get install -y git sudo 
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
COPY setup-taiga.sh / 
RUN chmod +x setup-taiga.sh
RUN /setup-taiga.sh

#nginx should be run in daemon mode to be properly managed by runit or other process managers
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

#populating runit launcher scripts
RUN mkdir /etc/service/nginx
ADD runit_scripts/nginx_runit.sh /etc/service/nginx/run
RUN chmod +x etc/service/nginx/run 
RUN mkdir /etc/service/postgresql
ADD runit_scripts/postgresql_runit.sh /etc/service/postgresql/run
RUN chmod +x /etc/service/postgresql/run 
RUN mkdir /etc/service/circus
ADD runit_scripts/circus_runit.sh /etc/service/circus/run
RUN chmod +x /etc/service/circus/run 

# Create a runit entry for rabbitMQ 
RUN mkdir -p /etc/service/rabbitmq
ADD runit_scripts/rabbit_runit.sh /etc/service/rabbitmq/run
RUN chown root /etc/service/rabbitmq/run
RUN chmod +x /etc/service/rabbitmq/run

# Create a runit entry for redis 
RUN  echo 'vm.overcommit_memory = 1' >> /etc/sysctl.conf
RUN sed -i "s|daemonize yes|daemonize no|g" /etc/redis/redis.conf
RUN mkdir -p /etc/service/redis
ADD runit_scripts/redis_runit.sh /etc/service/redis/run
RUN chown root /etc/service/redis/run
RUN chmod +x /etc/service/redis/run
