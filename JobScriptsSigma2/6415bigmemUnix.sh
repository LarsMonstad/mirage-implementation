#!/bin/bash -l
#SBATCH --account=nn9750k --job-name=bigmemtraining6415
#SBATCH --time=10-0:0:0
#SBATCH --ntasks=1 --cpus-per-task=64
#SBATCH --mem-per-cpu=15G
#SBATCH -e training4020.e
#SBATCH -o training4020.txt
#SBATCH --partition=bigmem

#SBATCH  --licenses=matlab@uio

module load MATLAB/2022b
module add libsndfile/1.0.28-GCCcore-9.3.0

# Run matlab taking your_matlab_program.m as input and show the output in the file
# your_matlab_program.out. The input file must be in the directory where you submit this script. 
# This is also where the output will be created.

matlab -nosplash -nodesktop -nodisplay < startUnix.m
