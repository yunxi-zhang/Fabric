#!/bin/bash
# The steps 1-3 will remove all docker iamges in a machine
# comment them out if this is not the right intention to do

# Step 1: stop all current docker containers including those not in this project
echo -e "\x1b[33mStep 1: Stop All Current Docker Containers Including Those Are Not In This Project \x1b[0m "
docker stop $(docker ps -aq)
# Step 2: remove all docker containers
echo -e "\x1b[33mStep 2: Remove All Docker Containers \x1b[0m "
docker rm -f $(docker ps -aq)
# Step 3: remove all docker images
echo -e "\x1b[33mStep 3: Remove All Docker Images \x1b[0m "
docker rmi -f $(docker images -aq)
# Step 4: show docker images
echo -e "\x1b[33mStep 4: Show Docker Images \x1b[0m "
docker images
# Step 5: remove all the files that will be generated in this project if they exist
echo -e "\x1b[33mStep 5: Remove All The Files That Will Be Generated In This Project If They Exist \x1b[0m "
rm -rf bin channel-artifacts config crypo-config scripts
# Step 6: show these files do not exist
echo -e "\x1b[33mStep 6: Show That These Files Do Not Exist \x1b[0m "
ls -al bin
ls -al channel-artifacts 
ls -al config
ls -al crypo-config
ls -al scripts

# Step 7: run all other shell files for this project
echo -e "\x1b[33mStep 7: Run All Other Shell Files In This Project \x1b[0m "
# export this variable so the sub shell files can use it
export CHANNELNAME="channel4"
./step1_downloadbin.sh
./step2_generateKey.sh
./step3_generateConfigTx.sh
./step4_runDockerCompose.sh
./step5_step5_putChannelConfigTxToContainer.sh

# Step 8: show all the running docker containers
echo -e "\x1b[33mStep 8: Show All The Running Docker Containers \x1b[0m "
docker ps 