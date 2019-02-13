#!/bin/bash
# The steps 1-3 will remove all docker iamges in a machine
# comment them out if this is not the right intention to do

# Step 1: stop all current docker containers including those not in this project
docker stop $(docker ps -aq)
# Step 2: remove all docker containers
docker rm -f $(docker ps -aq)
# Step 3: remove all docker images
docker rmi -f $(docker images -aq)
# Step 4: show docker images
docker images
# Step 5: remove all the files that will be generated in this project if they exist
rm -rf bin channel-artifacts config crypo-config
# Step 6: show these files do not exist
ls -al bin
ls -al channel-artifacts 
ls -al config
ls -al crypo-config

# run all other shell files for this project
./step1_downloadbin.sh
./step2_generateKey.sh
./step3_generateConfigTx.sh
./step4_runDockerCompose.sh

# show all the running docker containers
docker ps 