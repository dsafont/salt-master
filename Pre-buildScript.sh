#!/bin/bash

##Install python 
apt-get update
apt-get install -y python python-pip\         
                   apt-transport-https \
                   ca-certificates \
                   curl \
                   software-properties-common
                
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

#Install python docker API

curl -k -vvv https://pypi.python.org/packages/a2/7e/8d02472884a78dcb2ae0c5f5fe7783801670d8835402820bb9f156c0acc0/docker-2.4.2.tar.gz#md5=df46a59fbc383dc99fb031ec823d5638 -o docker-2.4.2.tar.gz
tar xvf docker-2.4.2.tar.gz
cd docker-2.4.2
python setup.py install

#add latest repo and install docker CE
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

 apt-get update
 apt-get install -y docker-ce

