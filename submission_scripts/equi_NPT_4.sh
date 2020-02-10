#!/bin/bash

#############################################################
## JOB DESCRIPTION                                         ##
#############################################################

# Minimize for 2 ps

#############################################################
## ADJUSTABLE PARAMETERS                                   ##
#############################################################
export sysname=$1
export inputdir=./
export outputdir=./
export mypsf=$(find $inputdir -name "$sysname*psf")
export mypdb=$(find $inputdir -name "$sysname*pdb")
export scripts_path="/scratch/jvant/F-type_ATPase_cc_analysis/NAMD_Equilibration"
export ensemble=NPT #or NPT
export inputname=equi_NPT_3.restart
export outputname=equi_NPT_4



export temp=300
export MS=0
export TS=10000000 # 10 ns


cmstr=$sysname-$outputname
#############################################################
## Submit job
#############################################################
jobid=$(squeue -u jvant -o "%.10i %j" | grep $sysname-${inputname%.*} | awk '{print $1}')

if [ -z "$jobid" ]
then
    sbatch \
	-N 1 \
	-n 8 \
	-t 6-00:00 \
	--gres=gpu:1 \
	-o slurm-${cmstr}.out \
	-p asinghargpu1 \
	-q asinghargpu1 \
	-J ${cmstr} \
	<<EOF
#!/bin/bash

# Load Modules
module load namd/2.13b1-cuda
cp $scripts_path/namd_scripts/run.inp ./

namd2 +p8 ./run.inp > $cmstr.log

EOF

else
    sbatch \
	-N 1 \
	-n 8 \
	-t 4-00:00 \
	--gres=gpu:1 \
	-o slurm-${cmstr}.out \
	-p asinghargpu1 \
	-q asinghargpu1 \
	-J ${cmstr} \
	-d afterany:$jobid \
	<<EOF
#!/bin/bash

# Load Modules
module load namd/2.13b1-cuda
cp $scripts_path/namd_scripts/run.inp ./

namd2 +p8 ./run.inp > $cmstr.log

EOF

fi
