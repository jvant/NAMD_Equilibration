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
cd ../
SCRIPTS_PATH=$(pwd)
SCRIPTS_PATH_sed="$(echo $SCRIPTS_PATH | sed 's/\//\\\//g')"

awk -v CWD=cwd -v PSF_PDB_NAME=psf_pdb_name -v STEP_NUM=step_num -v SCRIPTS_PATH=$SCRIPTS_PATH 'BEGIN {print CWD, PSF_PDB_NAME, STEP_NUM, SCRIPTS_PATH }'> ./config_params.str

echo "Simulating the following systems $systems"
for sys in $systems
do
    cd ../systems/$sys
    cp $SCRIPTS_PATH/namd_scripts/run.inp ./
    sed -e s/MYSYS_NAME/$sys/ -e s/STEP/1/ -e s/SCRIPTS_PATH/$SCRIPTS_PATH_sed/ $SCRIPTS_PATH/namd_scripts/step1_template.inp > ./step1.inp
    job=$(sed -e s/filename/step1/ $SCRIPTS_PATH/submission_scripts/batch.sh | bsub -P BIP115 -W $wall_time_min -nnodes $nnodes -J $sys | cut -f 2 -d' ')
    echo "submitted step1 for $sys"
    
    for STEP_NUM in {2..6}
    do
	sed -e s/MYSYS_NAME/$sys/ -e s/STEP/$STEP_NUM/ -e s/SCRIPTS_PATH/$SCRIPTS_PATH_sed/ $SCRIPTS_PATH/namd_scripts/step2_template.inp > ./step$STEP_NUM.inp
	job=$(sed -e s/filename/step$STEP_NUM/ $SCRIPTS_PATH/submission_scripts/batch.sh | bsub -P BIP115 -W $wall_time -nnodes $nnodes -J $sys -w ${job:1:6}  | cut -f 2 -d' ')
	echo "submitted step$STEP_NUM for $sys"
    done
    cd -
done
