#!/bin/bash

Date=$(date +%m)
Red='\033[35;1;4m'
Yellow='\033[1;36m'
NC='\033[0m'
rsync -Avazh  --progress  <SRC> <DEST>/$Date

if [ $? -eq 0 ]
then
   tar -cvzf <SRC>/$Date.tar.gz <DEST>/$Date
else
   echo -e " ${Red} Try again, There is Problem ${NC}"
fi

if [ $? -eq 0 ]
then
   rm -r <DEST>/$Date
else
   echo -e " ${Red} Try again, There is Problem ${NC}"
fi
