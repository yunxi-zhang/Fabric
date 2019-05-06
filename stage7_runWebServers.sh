#!/bin/bash

# import common.sh
source ./common.sh

stepInfo "Prepare Web Servers for 3 Orgs"

stepInfo "Kill existing node process if they exist"

#killall command doesn't work on redhat
killall node
#below commands work on redhat
kill `lsof -t -i:3001`
kill `lsof -t -i:3002`
kill `lsof -t -i:3003`

stepInfo "Delete webappbank if it exists"
if [ -d webappbank ]; then
    rm -rf webappbank
fi
ls -al webappbank

stepInfo "Delete webappseller if it exists"
if [ -d webappseller ]; then
    rm -rf webappseller
fi
ls -al webappseller

stepInfo "Delete webappbuyer if it exists"
if [ -d webappbuyer ]; then
    rm -rf webappbuyer
fi
ls -al webappbuyer

stepInfo "Run npm install in the webapp as a template web server"
cd ./webapp
npm install
npm rebuild
cp ./default.json ./node_modules/fabric-network/node_modules/fabric-client/config/default.json
stepInfo "Show new default.json in fabric-client"
head -2 ./node_modules/fabric-network/node_modules/fabric-client/config/default.json
cd ..

stepInfo "Show current path before creating new web server"
pwd

stepInfo "Creating A Web Server for Bank"
cp -r ./webapp ./webappbank
stepInfo "Show files in webappbank"
cd ./webappbank
pwd
ls -al 
stepInfo "Show new default.json in fabric-client"
head -2 ./node_modules/fabric-network/node_modules/fabric-client/config/default.json
stepInfo "Delete seller and buyer folders"
rm -rf seller buyer
stepInfo "Show seller and buyer folders are gone"
ls -al seller buyer
stepInfo "Delete the package.json"
rm package.json
stepInfo "Show package.json in webappbank is gone"
ls -al package.json
stepInfo "Copy package.json from bank folder"
cp ./bank/server.js ./server.js
cp ./bank/package.json ./package.json
stepInfo "Show the new server.js and package.json in webappbank"
ls -al server.js package.json
stepInfo "Run npm start in the background"
nohup npm start &
stepInfo "go back to the root path"
cd ..
pwd

stepInfo "Creating A Web Server for Seller"
cp -r ./webapp ./webappseller
stepInfo "Show files in webappseller"
cd ./webappseller
pwd
ls -al 
stepInfo "Show new default.json in fabric-client"
head -2 ./node_modules/fabric-network/node_modules/fabric-client/config/default.json
stepInfo "Delete bank and buyer folders"
rm -rf bank buyer
stepInfo "Show bank and buyer folders are gone"
ls -al bank buyer
stepInfo "Delete the package.json"
rm package.json
stepInfo "Show package.json in webappseller is gone"
ls -al package.json
stepInfo "Copy package.json from seller folder"
cp ./seller/server.js ./server.js
cp ./seller/package.json ./package.json
stepInfo "Show the new server.js and package.json in webappseller"
ls -al server.js package.json
stepInfo "Run npm start in the background"
nohup npm start &
stepInfo "go back to the root path"
cd ..
pwd

stepInfo "Creating A Web Server for Buyer"
cp -r ./webapp ./webappbuyer
stepInfo "Show files in webappbuyer"
cd ./webappbuyer
pwd
ls -al 
stepInfo "Show new default.json in fabric-client"
head -2 ./node_modules/fabric-network/node_modules/fabric-client/config/default.json
stepInfo "Delete bank and seller folders"
rm -rf bank seller
stepInfo "Show bank and seller folders are gone"
ls -al bank seller
stepInfo "Delete the package.json"
rm package.json
stepInfo "Show package.json in webappbuyer is gone"
ls -al package.json
stepInfo "Copy package.json from buyer folder"
cp ./buyer/server.js ./server.js
cp ./buyer/package.json ./package.json
stepInfo "Show the new server.js and package.json in webappbuyer"
ls -al server.js package.json
stepInfo "Run npm start in the background"
nohup npm start &
stepInfo "go back to the root path"
cd ..
pwd