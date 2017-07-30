# salt-master
Deployment of a dockerized salt master

#To build the project run
docker build -t salt-master .

#if the build is executed behind a corporate proxy run
 docker build --build-arg PROXY="10.0.2.10:3128" -t salt-master .
