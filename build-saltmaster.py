#!/usr/bin/env python
#Requirements:
#python3.x, docker-py2.x, docker 17.x

import docker
import sys, getopt, json

proxy = ''
buildargs_docker = {}
LogFile="./build.log"

try:
        opts, args = getopt.getopt(sys.argv[1:],"hp:",["proxy="])
except getopt.GetoptError:
        print 'error: python build-saltmaster.py -p $proxy:$port'
        sys.exit(2)

for opt, arg in opts:
        if opt == '-h':
                print 'python build-saltmaster.py -p $proxy:$port'
                sys.exit()
        elif opt in ("-p", "--proxy"):
                proxy = arg
                buildargs_docker = {'PROXY': proxy}

image_name = "salt_master:2017.7.0"
#c = docker.from_env()
cli = docker.APIClient(base_url='unix://var/run/docker.sock')

for line in cli.build(path = '.', rm=True, tag = image_name, nocache=True, buildargs=buildargs_docker):
        LineDecoded=json.loads(line)["stream"]
        print LineDecoded
        F = open(LogFile,"a")
        F.write(LineDecoded)
        F.close()
#for line in c.images.build(path = '.', tag = image_name, nocache=True, stream=True):
#       print line.strip()
#ctr = c.create_container(image_name, volumes='./target:/target')
#c.start(ctr)
