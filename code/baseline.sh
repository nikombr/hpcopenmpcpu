#!/bin/bash
#BSUB -J baseline # name
#BSUB -o outfiles/baseline_%J.out # output file
#BSUB -q hpcintro 
#BSUB -n 24 ## cores (24 is maximum)
#BSUB -R "rusage[mem=1GB]" 
#BSUB -W 60 # useable time in minutes
##BSUB -N # send mail when done
#BSUB -R "span[hosts=1]"

N=55
ITER=100000
TOLERANCE=1e-8
INIT="old" ## "old" or "init"

rm -rf results/par_bas_j_.txt
rm -rf results/par_bas_gs.txt

for threads in {25..185..7};
do  
    OMP_NUM_THREADS=$threads ./par_bas_j $N $ITER $TOLERANCE 20 >> results/par_bas_j.txt
    OMP_NUM_THREADS=$threads ./par_bas_gs $N $ITER $TOLERANCE 20 >> results/par_bas_gs.txt

done

exit 0

