#!/bin/bash

# import common.sh
source ./common.sh

stepInfo "Run Docker Containers By Using The Docker Compose File"
docker-compose -f docker-compose-cli.yaml up -d