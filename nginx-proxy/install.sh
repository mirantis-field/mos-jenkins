#!/bin/bash

docker-compose -f nginx-proxy-letsencrypt.yml up

docker-compose -f jenkins.yml up

