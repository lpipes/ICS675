#!/bin/bash
#SBATCH --job-name=TEST
#SBATCH --account=ics675
#SBATCH --partition=ics675
#SBATCH --time=00:00:30
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mail-type=START,END,FAIL
#SBATCH --mail-user=lpipes@hawaii.edu

echo "hello world"
