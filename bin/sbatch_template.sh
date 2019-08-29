#!/bin/bash

#SBATCH -N 1
#SBATCH -n 8
#SBATCH -p asinghargpu1
#SBATCH -q asinghargpu1
#SBATCH --gres=gpu:GTX1080:1
#SBATCH -t 8-12:00
#SBATCH -e $1.out

module load namd/2.13b1-cuda

namd2 +p8 $1.inp > $1.log
