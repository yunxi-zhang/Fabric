#!/bin/bash
echo -e "\x1b[33mGenerate Keys And X509 Certificates For Participants \x1b[0m "
./bin/cryptogen generate --config=./crypto-config.yaml