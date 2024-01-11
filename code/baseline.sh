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
START_T=5
INIT="old" ## "old" or "init"

lscpu

rm -rf results/par_bas_j_$INIT.txt
rm -rf results/par_bas_gs_$INIT.txt

for threads in {1..24..1};
do  
    echo -n $threads " " >> results/par_bas_j_$INIT.txt
    echo -n $threads " " >> results/par_bas_gs_$INIT.txt
    OMP_NUM_THREADS=$threads ./par_bas_j $N $ITER $TOLERANCE $START_T >> results/par_bas_j_$INIT.txt
    OMP_NUM_THREADS=$threads ./par_bas_gs $N $ITER $TOLERANCE $START_T >> results/par_bas_gs_$INIT.txt

done

exit 0

