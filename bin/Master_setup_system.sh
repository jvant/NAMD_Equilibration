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
# mkdir ../../systems/
# Systems that did not finish building 1h8e/ 4z1m/  5hkk/  6foc/  6n2y/
for sys in 6foc
do
    
    mkdir ../../systems/$sys/
    cp ../../ITASSER_models/$sys-merged.pdb ../../systems/$sys/
    cd ../../systems/$sys/
    vmd -dispdev text -eofexit < $programs_path/usefull_scripts/build_system.pgn -args $sys-merged.pdb $programs_path $sys

    echo " "
    echo "Built system dir and psf for $cmstr"
    echo " "
    cd -
done
exit
