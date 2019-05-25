# Shell files from stage1 to stage7.
1) stage1_downloadbin.sh is a shell file that will download the necessary bin folders containing all useful command tools of a particular version of Hyperledger Fabric. The current version used in this project is 1.4.0, but this version can be changed by assigning a new version number to the enviroment variable called "VERSION". Note: no testing is done in this project to make sure using a new version of these tools would be compatible with other Fabric functions in this project.
2) stage2_generateKey.sh is a shell file that will generate all the certificates for all three orgs. It uses a command tool called cryptogen in the bin folder to run the crypto-config.yaml file as mentioned earlier.
3) stage3_generateConfigTx.sh is a shell file that will create files in a folder called "channel-artifacts" to be used for channels based on the crypto-config.yaml file that is also a config file provided by Hyperledger Fabric.
4) stage4_runDockerCompose.sh is a shell file that will run the 5 Fabric docker images as running containers as defined in a file called "docker-compose-cli.yaml".
5) stage5_putChannelConfigTxToContainer.sh file is a shell file that will create channels by using the files in the "channel-artifacts" folder in the running docker containers.
6) stage6_intallAndInstantiateChaincode.sh is a shell file that will install the right chaincode fies to the right peer in each channel, and instantiate each chaincode file for only once.
7) stage7_runWebServer.sh will run 3 web servers for 3 organisations respectively.
