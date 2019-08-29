#!/bin/bash

###########################################################################
#
#        Created by:  John Vant
#                     jvant@asu.edu
#                     Biodesign Institute, ASU
#
#        This Script is meant to setup a equilibration simulaiton in namd
#        
#
###########################################################################

# Usage: bash Master_setup_all_systems.sh

###########################################################################
# Main

bin_dir=$(pwd)
programs_path=$bin_dir/..
mkdir ../../systems/
# Systems that did not finish building 1h8e/ 4z1m/  5hkk/  6foc/  6n2y/
for i in $(ls ../../F1_only_pdbs/)
do
    cmstr=${i:0:4}
    mkdir ../../systems/$cmstr/
    cp ../../F1_only_pdbs/$i ../../systems/$cmstr/
    cd ../../systems/$cmstr/
    vmd -dispdev text -eofexit < $programs_path/include/build_system.pgn -args $i $programs_path $cmstr

    echo " "
    echo "Built system dir and psf for $cmstr"
    echo " "
done
exit
