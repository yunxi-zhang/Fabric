## Repo Description
This repo is mainly used to run a fabric network and web services for all the orgnizations in a Linux or Mac machine as to set up a local development environment for developers. It can work with my [ReactApp repo](https://github.com/yunxi-zhang/ReactApp) together to be used as a simple DLT demo.

## Prerequisites
To run this repo, a user has to install the below tools on a local machine.
1. **OS**: MacOS 10.14.6 (properly tested) or Unix/Linux(not properly tested yet).
2. **node version**: 10.17.0.
3. **docker version**: Docker version 19.03.4, build 9013bf5.
4. **docker compose version**: version 1.24.1, build 4667896b.
5. **Hyperledger Fabric**: only have successfully tested for version 1.4.

## Repo Structure ##
This section clarifies what are the purposes of folders and files used in this repo.
<pre>
|__ <b>base</b>: This folder contains base docker compose files that will be used in a docker-compose-cli.yaml
|__ <b>chaincdoe</b>: This folder contains all the chaincode files that will be used in all the Fabric docker containers.
|__ <b>chaincode-unit-tests</b>: This folder contains all the unit test files for all the chaincode files. Instructions of how to run them is shown in a seperate section later.
|__ <b>webapp</b>: This folder contains all the files for each organisation to run as Web Services.
|__ <b>.env</b>: This file defines environmental variables used in the docker-compose-cli.yaml.
|__ <b>chaincode_unit_test_file_gen.sh</b>: This shell script is used as a prerequisite to run all the unit tests for the chaincode. Instruction is given in a seperate section later.
|__ <b>common.sh</b>: This shell script defines the styling of information printed out. It is used by other shell script files.
|__ <b>configtx.yaml</b>: This is a Fabric specific config file. It comes from the offical Fabric website. It defines all the participants in a Fabric network and channels. The file is an input to be used in a Fabric Command Line tool called configtxgen in a bin folder. The output will be a number of Fabric channel files that will be used to create new channels in a Fabric network. In this repo, the command to run this file will be covered in a file called "stage3_generateConfigTx.sh". Details are given in a seperate section later.
|__ <b>cryto-config.yaml</b>: This is a Fabric specific config file. It mainly defines the participants in a Fabric network, and also defines how many peers should be created for each participant. This file is an input to be used in a Fabric Command Line tool called "cryptogen" in the bin folder. The output will be all the TLS certificates for each organization. Actually, in this repo, this tool is used to simulate how a Fabric CA is going to issue TLS certificates for all the Fabric nodes.
|__ <b>docker-compose-cli.yaml</b>: This is the main docker compose file that will inherit the base docker compose files in the "bin" folder (will be created after stage1_downloadbin.sh runs) and spin up all docker containers for each participant to set up a Fabric network.
|__ <b>runAllStepsInOne.sh</b>: This is a shell file that will run all other shell files named in a way like "stageX_{step description}.sh".
|__ <b>stageX_{step description}.sh</b>: These files are mainly used to automate the setup of a Fabric network in a local machine to quickly set up a local development environment. Details are given in a seperate section later.
</pre>

## Shell files: StageX_{step description} - from stage1 to stage7
1. **stage1_downloadbin.sh** is a shell file that will download the necessary bin folders containing all useful command tools of a particular version of Hyperledger Fabric. The current version used in this project is 1.4.0, but this version can be changed by assigning a new version number to the enviroment variable called "VERSION". Note: no testing is done in this project to make sure using a new version of these tools would be compatible with other Fabric functions in this project.
2. **stage2_generateKey.sh** is a shell file that will generate all the certificates for all three orgs. It uses a command tool called cryptogen in the bin folder to run the crypto-config.yaml file as mentioned earlier.
3. **stage3_generateConfigTx.sh** is a shell file that will create files in a folder called "channel-artifacts" to be used for channels based on the crypto-config.yaml file that is also a config file provided by Hyperledger Fabric.
4. **stage4_runDockerCompose.sh** is a shell file that will run the 5 Fabric docker images as running containers as defined in a file called "docker-compose-cli.yaml".
5. **stage5_putChannelConfigTxToContainer.sh** file is a shell file that will create channels by using the files in the "channel-artifacts" folder in the running docker containers.
6. **stage6_intallAndInstantiateChaincode.sh** is a shell file that will install the right chaincode fies to the right peer in each channel, and instantiate each chaincode file for only once.
7. **stage7_runWebServer.sh** will run 3 web servers for 3 organisations respectively.

## Web Servers
A folder called webapp in this repo works as a template of a web server for each org.
Basically, each org will have its own web server that will receive HTTP requests from a frontend first, then the web server will access its own org's blockchain/DLT ledger(i.e. the Fabric peer node for each org) to either query or update data on the ledger and send HTTP responses to the frontend.

**Note**: Practically, running a web server is isloated from a blockchain environment, but make the right REST apis calls to the web server from a frontend does require that the blockchain environment is already setup successfully.

## Set up and run the Blockchain/DLT environment and Web Servers, only supported in either a Linux and macOS machine
Run the file called 'runAllStepsInOne.sh' file, will auto set up a Fabric blockchain/DLT environment and set up 3 web servers in the right order.

The right syntax to run this file, if a user has already change the directory to this repo.
```
./runAllStepsInOne.sh
```

**Note**: this file actually calls other shell files from stage 1 to stage 7 in the right order. Before running stage 1, it will remove all existing docker containers, docker images and other docker info in a machine to make sure a new blockchain environment will be set up from a clean environment. A user who would not like this feature to work that will delete other docker containers should comment out the relevant code in this file.

## Case Description
The case scenairo in this repo is fictional, it only demonstrates how Fabric can use different channels to set the right permission control to the the right organisations to access the right chaincode. Three organisations: (1) **Bank**, (2) **Seller** and (3) **Buyer** are invovled in this repo. Two separate channels are set up. **ChannelSeller** is set up for the **Bank** and **Seller** only and **ChannelBuyer** is set up for the **Bank** and **Buyer** only. The detailed channel configuration can be found in the file called "configtx.yaml". 

The following shows the channel config section on line 304 in the configtx.yaml file.
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

These two channel names will be used when creating artifact files for channel creation. In this repo, the two channel names are defined as two separate environment variables (i.e. $CHANNEL_PROFILE1 and $CHANNEL_PROFILE2) in the "runAllStepsInOne.sh" file. They will be called in the "stage3_generateConfigTx.sh" file. Also, the **OrdererGenesis** in the **Profiles** section will be used in the "stage3_generateConfigTx.sh" file as well for generating the genesis block file. 

The following shows the two variables on line 39 in the "runAllStepsInOne.sh" file. 
```
    export CHANNEL_PROFILE1=ChannelSeller
    export CHANNEL_PROFILE2=ChannelBuyer
```

The following shows where the "OrdererGenesis" and "ChannelSeller" are used on line 9 in the "stage3_generateConfigTx.sh" file.
```
    ./bin/configtxgen -configPath ./ -profile OrdererGenesis -outputBlock ./channel-artifacts/genesis.block 
    ./bin/configtxgen -configPath ./ -profile $CHANNEL_PROFILE1 -outputCreateChannelTx ./channel-artifacts/$CHANNEL_NAME1.tx -channelID $CHANNEL_NAME1
    stepInfo "Generating files for $CHANNEL_NAME1"
    # generate channel transaction artifact in channel1
    ./bin/configtxgen -configPath ./ -profile $CHANNEL_PROFILE1 -outputCreateChannelTx ./channel-artifacts/$CHANNEL_NAME1.tx -channelID $CHANNEL_NAME1
    # generate anchor peer for seller in channel1
    ./bin/configtxgen -configPath ./ -profile $CHANNEL_PROFILE1 -outputAnchorPeersUpdate ./channel-artifacts/sellerMSPanchors_$CHANNEL_NAME1.tx -channelID $CHANNEL_NAME1 -asOrg SellerMSP
    # generate anchor peer for bank in channel1
    ./bin/configtxgen -configPath ./ -profile $CHANNEL_PROFILE1 -outputAnchorPeersUpdate ./channel-artifacts/bankMSPanchors_$CHANNEL_NAME1.tx -channelID $CHANNEL_NAME1 -asOrg BankMSP
```

## Web Server Port Numbers
| Orgnaization     | Port |
| ----------- | ----------- |
| Bank | 3001 |
| Buyer | 3002 |
| Seller | 3003 |

## Testing ##
To test if a Fabric Blockchain network as well as Web Servers are up and running, one can type in the below API for Bank in a browser or a tool like Postman for testing.
```
http://localhost:3001/bank/sellerBalance
```

If everything works, one should be able to see a number - 150 shown as a response.