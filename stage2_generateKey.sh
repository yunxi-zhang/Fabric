#!/bin/bash

# import common.sh
source ./common.sh

stepInfo "Generate Keys And X509 Certificates For Participants"
./bin/cryptogen generate --config=./crypto-config.yaml