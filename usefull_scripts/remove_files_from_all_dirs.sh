#!/bin/bash

echo "What would you like to remove?  Remember to be careful what you type!!!"
read files
var=$(ls ../put_pdbs_here)
for i in $var
do
    cd ../systems/${i:0:4}/
    pwd
    echo ${i:0:4}
    echo " "
    rm $files
    cd -
done
