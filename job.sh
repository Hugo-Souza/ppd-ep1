#!/bin/bash
#SBATCH -J pi-integral  	        # Job name
#SBATCH -p fast                     # Job partition
#SBATCH -n 1                        # Number of processes
#SBATCH -t 01:30:00                 # Run time (hh:mm:ss)
#SBATCH --cpus-per-task=40          # Number of CPUs per process
#SBATCH --output=%x.%j.out          # Name of stdout output file - %j expands to jobId and %x to jobName
#SBATCH --error=%x.%j.err           # Name of stderr output file
#SBATCH --mail-user=hugo.souza@estudante.ufscar.br
#SBATCH --mail-type=All

echo "*** SEQUENTIAL ***"
srun singularity run container.sif pi_seq 1000000000


echo "*** PTHREAD 1***"
srun singularity run container.sif pi_pth 1000000000 1

echo "*** PTHREAD 2***"
srun singularity run container.sif pi_pth 1000000000 2

echo "*** PTHREAD 5***"
srun singularity run container.sif pi_pth 1000000000 5

echo "*** PTHREAD 10***"
srun singularity run container.sif pi_pth 1000000000 10

echo "*** PTHREAD 20***"
srun singularity run container.sif pi_pth 1000000000 20

echo "*** PTHREAD 40***"
srun singularity run container.sif pi_pth 1000000000 40


echo "*** OPENMP 1***"
export OMP_NUM_THREADS=1
srun singularity run container.sif pi_omp 1000000000

echo "*** OPENMP 2***"
export OMP_NUM_THREADS=2
srun singularity run container.sif pi_omp 1000000000

echo "*** OPENMP 5***"
export OMP_NUM_THREADS=5
srun singularity run container.sif pi_omp 1000000000

echo "*** OPENMP 10***"
export OMP_NUM_THREADS=10
srun singularity run container.sif pi_omp 1000000000

echo "*** OPENMP 20***"
export OMP_NUM_THREADS=20
srun singularity run container.sif pi_omp 1000000000

echo "*** OPENMP 2***"
export OMP_NUM_THREADS=40
srun singularity run container.sif pi_omp 1000000000



# OBS: if it is an MPI job
# use --mpi=pmi2
# srun --mpi=pmi2 singularity run container.sif mmul_seq 1000
