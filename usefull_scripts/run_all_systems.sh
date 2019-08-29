#!/bin/bash

var=$(ls ../put_pdbs_here)
for i in $var
do
    cd ../systems/${i:0:4}/
    pwd
    echo ${i:0:4}
    echo " "
    echo "Running System :}"
    echo " "
    bash ./jobpip.sh
    cd -
done
