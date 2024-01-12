#!/bin/bash
#BSUB -J baseline # name
#BSUB -o outfiles/baseline_%J.out # output file
#BSUB -q hpcintro 
#BSUB -n 24 ## cores (24 is maximum)
#BSUB -R "rusage[mem=1GB]" 
#BSUB -W 60 # useable time in minutes
##BSUB -N # send mail when done
#BSUB -R "span[hosts=1]"

N=495 ## 55, 165, 275, 385, 495
ITER=10 ## 200000, 8000, 1500, 600, 10
TOLERANCE=-1
START_T=5
INIT="old" ## "old" or "init"

lscpu

rm -rf results/no_opt_par_bas_j_$N.txt

for threads in {1..24..1};
do  
    echo -n $threads " " >> results/no_opt_par_bas_j_$N.txt
    OMP_NUM_THREADS=$threads OMP_SCHEDULE=static ./par_bas_j $N $ITER $TOLERANCE $START_T >> results/no_opt_par_bas_j_$N.txt

done

exit 0

