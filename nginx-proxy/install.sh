#!/bin/bash

sudo docker-compose -f nginx-proxy-letsencrypt.yml up -d

sudo docker-compose -f jenkins.yml up -d

