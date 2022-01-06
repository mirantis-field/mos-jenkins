#!/bin/bash

sudo docker-compose -f nginx-proxy-letsencrypt.yml up

sudo docker-compose -f jenkins.yml up

