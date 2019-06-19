## Shell files from stage1 to stage7
1) stage1_downloadbin.sh is a shell file that will download the necessary bin folders containing all useful command tools of a particular version of Hyperledger Fabric. The current version used in this project is 1.4.0, but this version can be changed by assigning a new version number to the enviroment variable called "VERSION". Note: no testing is done in this project to make sure using a new version of these tools would be compatible with other Fabric functions in this project.
2) stage2_generateKey.sh is a shell file that will generate all the certificates for all three orgs. It uses a command tool called cryptogen in the bin folder to run the crypto-config.yaml file as mentioned earlier.
3) stage3_generateConfigTx.sh is a shell file that will create files in a folder called "channel-artifacts" to be used for channels based on the crypto-config.yaml file that is also a config file provided by Hyperledger Fabric.
4) stage4_runDockerCompose.sh is a shell file that will run the 5 Fabric docker images as running containers as defined in a file called "docker-compose-cli.yaml".
5) stage5_putChannelConfigTxToContainer.sh file is a shell file that will create channels by using the files in the "channel-artifacts" folder in the running docker containers.
6) stage6_intallAndInstantiateChaincode.sh is a shell file that will install the right chaincode fies to the right peer in each channel, and instantiate each chaincode file for only once.
7) stage7_runWebServer.sh will run 3 web servers for 3 organisations respectively.

## Web Servers
A folder called webapp in this repo works as a template of a web server for each org.
Basically, each org will have its own web server that will receive HTTP requests from a frontend first, then the web server will access its own org's blockchain/DLT ledger(i.e. the Fabric peer node for each org) to either query or update data on the ledger and send HTTP responses to the frontend.

**Note**: Practically, running a web server is isloated from a blockchain environment, but make the right REST apis calls to the web server from a frontend does require that the blockchain environment is already setup successfully.

## Set up and run the Blockchain/DLT environment and Web Servers, only supported in either a Linux and macOS machine
Run the file called 'runAllStepsInOne.sh' file, will auto set up a Fabric blockchain/DLT environment and set up 3 web servers in the right order.

**Note**: this file actually calls other shell files from stage 1 to stage 7 in the right order. Before running stage 1, it will remove all existing docker containers, docker images and other docker info in a machine to make sure a new blockchain environment will be set up from a clean environment. A user who would not like this feature to work that will delete other docker containers should comment out the relevant code in this file.

## Case Description
The case scenairo in this repo is a fake one, it only demonstrates how Fabric can use different channels to set the right permission control to the the right organisations to access the right chaincode. Three organisations: (1) bank, (2) seller and (3) buyer are invovled in this repo. Two separate channels are set up. "ChannelSeller" is set up for the bank and seller only and "ChannelBuyer" is set up for the bank and buyer only. The detailed channel configuration can be found in the file called "configtx.yaml". 

The following shows the channel config in the configtx.yaml file.
    Profiles:

        OrdererGenesis:
            <<: *ChannelDefaults
            Orderer:
                <<: *OrdererDefaults
                Organizations:
                    - *OrdererOrg
                Capabilities:
                    <<: *OrdererCapabilities
            Consortiums:
                SellerBankConsortium:
                    Organizations:
                        - *Seller
                        - *Bank
                BuyerBankConsortium:
                    Organizations:
                        - *Buyer
                        - *Bank
        ChannelSeller:
            Consortium: SellerBankConsortium
            Application:
                <<: *ApplicationDefaults
                Organizations:
                    - *Seller
                    - *Bank
                Capabilities:
                    <<: *ApplicationCapabilities
        ChannelBuyer:
            Consortium: BuyerBankConsortium
            Application:
                <<: *ApplicationDefaults
                Organizations:
                    - *Buyer
                    - *Bank
                Capabilities:
                    <<: *ApplicationCapabilities

These two channel names will be used when creating artifact files for channel creation. In this repo, the two channel names are defined as two separate environment variables (i.e. $CHANNEL_PROFILE1 and $CHANNEL_PROFILE2) in the "runAllStepsInOne.sh" file. They will be called in the "stage3_generateConfigTx.sh" file. Also, the "OrdererGenesis" in the "Profiles" section will be used in the "stage3_generateConfigTx.sh" file as well for generating the genesis block file. 