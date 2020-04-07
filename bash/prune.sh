#!/bin/bash

#Start docker compose
echo "- Docker prune..."
docker -y system prune -a
docker -y volume prune
