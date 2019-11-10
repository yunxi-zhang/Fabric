#!/bin/bash

# copy all the chaincode files to the chaincode-unit-tests folder to do the chaincode unit tests
find ./chaincode -iname '*.js' -exec cp {} ./chaincode-unit-tests \;

# get all the paths for these chaincode files and output them in the find.log file.
find ./chaincode -iname 'chaincode_*.js' > find.log

# Get all the names for each chaincode file
sed -i '' 's/.\/chaincode\///' ./find.log
sed -i '' 's/\/chaincode_[[:graph:]]*//' ./find.log
sed -i '' 's/.js//' ./find.log

# Loop through the find.log file and auto update two lines in each chaincode file
while IFS="" read -r p || [ -n "$p" ]
do
  # update the class name with the right chaincode file name
  sed -i '' "s/const Chaincode = class {/class ${p}1 {/" ./chaincode-unit-tests/chaincode_$p.js
  sed -i '' "s/shim.start(new Chaincode());/module.exports = ${p}1;/" ./chaincode-unit-tests/chaincode_$p.js
done < find.log