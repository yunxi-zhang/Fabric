#!/bin/bash
# The steps 1-3 will remove all docker iamges in a machine
# comment them out if this is not the right intention to do

# Step 1: stop all current docker containers including those not in this project
docker stop $(docker ps -aq)
# Step 2: remove all docker containers
docker rm -f $(docker ps -aq)
# Step 3: remove all docker images
docker rmi -f $(docker images -aq)

# run all other shell files for this project
./step1_downloadbin.sh
./step2_generateKey.sh
./step3_generateConfigTx.sh
./step4_runDockerCompose.sh