#!/bin/bash
# The steps 1-3 will remove all docker iamges in a machine
# comment them out if this is not the right intention to do

# Step 1: stop all current docker containers including those not in this project
echo -e "\x1b[34mStep 1:stop all current docker containers including those not in this project \x1b[0m "
docker stop $(docker ps -aq)
# Step 2: remove all docker containers
echo -e "\x1b[34mStep 2:remove all docker containers \x1b[0m "
docker rm -f $(docker ps -aq)
# Step 3: remove all docker images
echo -e "\x1b[34mStep 3: remove all docker images \x1b[0m "
docker rmi -f $(docker images -aq)
# Step 4: show docker images
echo -e "\x1b[34mStep 4: show docker images \x1b[0m "
docker images
# Step 5: remove all the files that will be generated in this project if they exist
echo -e "\x1b[34mStep 5: remove all the files that will be generated in this project if they exist \x1b[0m "
rm -rf bin channel-artifacts config crypo-config
# Step 6: show these files do not exist
echo -e "\x1b[34mStep 6: show these files do not exist \x1b[0m "
ls -al bin
ls -al channel-artifacts 
ls -al config
ls -al crypo-config

# Step 7: run all other shell files for this project
echo -e "\x1b[34mStep 7: run all other shell files for this project \x1b[0m "
./step1_downloadbin.sh
./step2_generateKey.sh
./step3_generateConfigTx.sh
./step4_runDockerCompose.sh

# Step 8: show all the running docker containers
echo -e "\x1b[34mStep 8: show all the running docker containers \x1b[0m "
docker ps 