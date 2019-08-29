#!/bin/bash

## Usage: bash make-configuration-files.sh

# 3 configuration files needed in namd_scripts/ dir
# minimization-template.inp
# no-minimization-template.inp
# step1_template.inp
# jobpip_template.sh

var=$(ls ../put_pdbs_here)
for name in $var
do
    echo " "
    echo ${name:0:4}
    cd ../systems/${name:0:4}/
    pwd
    echo " "

    # Minimize for 100 ps
    cat ../../namd_scripts/step1_template.inp > step1_equilibration.inp
    sed -i s/FILENAME/${name:0:4}-solv_ion/ step1_equilibration.inp

    # Minimize for 10 ps each step then equilibrate for 10 ps each step
    for i in {2..5}
    do
	cat ../../namd_scripts/minimization-template.inp > step$i\_equilibration.inp
	sed -i s/"STEPNUM"/"$i"/ step$i\_equilibration.inp
	sed -i s/FILENAME/${name:0:4}-solv_ion/ step$i\_equilibration.inp
    done

    # Equilibrate for 100 ps each step
    for i in {6..15}
    do
	cat ../../namd_scripts/no-minimization-template.inp > step$i\_equilibration.inp
	sed -i s/"STEPNUM"/"$i"/ step$i\_equilibration.inp
	sed -i s/FILENAME/${name:0:4}-solv_ion/ step$i\_equilibration.inp
    done

    # Submission scripts
    for i in {1..15}
    do
	cat ../../namd_scripts/sbatch_template.sh > ${name:0:4}.$i.sh
	sed -i s/step1_equilibration/step$i\_equilibration/g ${name:0:4}.$i.sh
    done

    # make jobpip.sh script
    cat ../../namd_scripts/jobpip_template.sh > jobpip.sh
    sed -i s/NAME/${name:0:4}/g jobpip.sh

    cd -
done
