#!/bin/bash

# Arguments
CONFIG_FILE=filename

module load spectrum-mpi
module load cuda/9.2.148
module load fftw

jsrun -n384 -r6 -a1 -g1 -c7 -brs /ccs/home/jimp/summit/build_nov/namd/Linux-POWER-xlC.pamicuda/namd2 ./$CONFIG_FILE.inp +ppn 7 +pemap 0-83:4,88-171:4 +ignoresharing >& ./$CONFIG_FILE.log
