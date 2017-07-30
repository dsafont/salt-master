FROM ubuntu:16.04

MAINTAINER David Safont <dasacer89@gmail.com>

##Proxy config
ARG PROXY
ENV PROXY=${PROXY}

RUN if [ ! -z $PROXY ];then export HTTP_PROXY="http://"$PROXY && export HTTPS_PROXY="https://"$PROXY;fi

COPY 80proxy_apt /etc/apt/apt.conf.d/80proxy

RUN apt-get update && apt-get upgrade -y &&\
    apt-get install wget sudo -y && \
    if [ ! -z $PROXY ];then echo "http_proxy = http://"$PROXY  >> /etc/wgetrc;fi && \
    if [ ! -z $PROXY ];then echo "https_proxy = https://"$PROXY >> /etc/wgetrc;fi && \
    wget -O - https://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add - && \
    echo "deb http://repo.saltstack.com/apt/ubuntu/16.04/amd64/latest xenial main" > /etc/apt/sources.list.d/saltstack.list && \
    apt-get update && \
    apt-get install salt-master salt-ssh salt-api salt-cloud -y

VOLUME ["/etc/salt", "/var/cache/salt", "/var/logs/salt", "/srv/salt"]

# Add Run File

ADD run.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh

#Cleanup build files

RUN if [ ! -z $PROXY ];then rm -f /etc/apt/apt.conf.d/80proxy &&  sed -i "/$PROXY/d" /etc/wgetrc;fi

EXPOSE 4505 4506

CMD "/usr/local/bin/run.sh"
