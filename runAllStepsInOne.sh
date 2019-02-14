#!/bin/bash

# import common.sh
source ./common.sh

# The steps 1-3 will remove all docker iamges in a machine
# comment them out if this is not the right intention to do

# Step 1: stop all current docker containers including those not in this project
stepInfo "Step 1: Stop All Current Docker Containers Including Those Are Not In This Project"
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
echo -e "\x1b[33mPleaes type in a channel name \x1b[0m "
read channelName
echo -e "\x1b[33mThe channel name you just typed in: $channelName\x1b[0m "
export CHANNELNAME=$channelName
./stage1_downloadbin.sh
./stage2_generateKey.sh
./stage3_generateConfigTx.sh
./stage4_runDockerCompose.sh

# Step 8: show all the running docker containers
echo -e "\x1b[33mStep 8: Show All The Running Docker Containers \x1b[0m "
docker ps 


echo -e "\x1b[33mSleeping for 10 seconds ... \x1b[0m "
sleep 10
echo -e "\x1b[33mEnd of sleeping \x1b[0m "
# stage 5 runs only after docker containers are running
./stage5_putChannelConfigTxToContainer.sh