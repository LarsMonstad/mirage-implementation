#!/bin/bash -l
#SBATCH --account=nn9750k --job-name=AnfJob20
#SBATCH --time=03:00:00
#SBATCH --ntasks=1 --cpus-per-task=20
#SBATCH --mem-per-cpu=3G
#SBATCH -e Anf20.e
#SBATCH -o Anf20.txt

#SBATCH  --licenses=matlab@uio

module load MATLAB/2021b
module add libsndfile/1.0.28-GCCcore-9.3.0

# Run matlab taking your_matlab_program.m as input and show the output in the file
# your_matlab_program.out. The input file must be in the directory where you submit this script. 
# This is also where the output will be created.

matlab -nosplash -nodesktop -nodisplay < startUnix.m

# If you remove the part:
# > your_matlab_program.out
# the output will instead be shown in the file output_file.o specified above
