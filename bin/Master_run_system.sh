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

# Arguments
systems=( "$@" )

###########################################################################
# Define parameters
nnodes=64
wall_time_min=1:00
wall_time=3:00

###########################################################################
# Main
ln -s ../../systems/ systems
cd ../
SCRIPTS_PATH=$(pwd)
SCRIPTS_PATH_sed="$(echo $SCRIPTS_PATH | sed 's/\//\\\//g')"
# sed -e s/MYSYS_NAME/$sys/ -e s/STEP/1/ -e s/SCRIPTS_PATH/$SCRIPTS_PATH_sed/ $SCRIPTS_PATH/namd_scripts/step1_template.inp > ./step1.inp

echo "Simulating the following systems $systems $@"
# echo $SCRIPTS_PATH/submission_scripts/min.sh
for sys in $@
do
    cd ../systems/$sys

    # $SCRIPTS_PATH/submission_scripts/min.sh $sys
    # $SCRIPTS_PATH/submission_scripts/ann.sh $sys
    # $SCRIPTS_PATH/submission_scripts/equi_NVT_1.sh $sys
#    $SCRIPTS_PATH/submission_scripts/equi_NPT_1.sh $sys
    $SCRIPTS_PATH/submission_scripts/equi_NPT_3.sh $sys
    $SCRIPTS_PATH/submission_scripts/equi_NPT_4.sh $sys

    cd -
done
