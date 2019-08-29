#!/bin/bash

#Usage: bash jobpip.sh

#first job
jobid=$(sbatch  sbatch.sh step1_minimization  | cut -f 4 -d' ')
echo $jobid

#Dependent Jobs
for i in {2..7}
do
    jobid=`sbatch -d afterany:$jobid sbatch.sh step$i\_equilibration | cut -f 4 -d' '`
    echo $jobid
done
