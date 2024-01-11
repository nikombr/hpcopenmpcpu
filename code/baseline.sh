#!/bin/bash
#BSUB -J baseline # name
#BSUB -o outfiles/baseline_%J.out # output file
#BSUB -q hpcintro 
#BSUB -n 24 ## cores (24 is maximum)
#BSUB -R "rusage[mem=1GB]" 
#BSUB -W 60 # useable time in minutes
##BSUB -N # send mail when done
#BSUB -R "span[hosts=1]"

N=165 ## 55, 165, 275, 385
ITER=10000 ## 350000, 10000, 2000, 800
TOLERANCE=-1
START_T=5
INIT="old" ## "old" or "init"

lscpu

rm -rf results/par_bas_j_dynamic_$INIT.$N.txt
rm -rf results/par_bas_j_static_$INIT.$N.txt
rm -rf results/par_bas_gs_$INIT.$N.txt

for threads in {1..24..1};
do  
    echo -n $threads " " >> results/par_bas_j_dynamic_$INIT.$N.txt
    echo -n $threads " " >> results/par_bas_j_static_$INIT.$N.txt
    echo -n $threads " " >> results/par_bas_gs_$INIT.$N.txt
    OMP_NUM_THREADS=$threads OMP_SCHEDULE=dynamic,1 ./par_bas_j $N $ITER $TOLERANCE $START_T >> results/par_bas_j_dynamic_$INIT.$N.txt
    OMP_NUM_THREADS=$threads OMP_SCHEDULE=static,1 ./par_bas_j $N $ITER $TOLERANCE $START_T >> results/par_bas_j_static_$INIT.$N.txt
    OMP_NUM_THREADS=$threads ./par_bas_gs $N $ITER $TOLERANCE $START_T >> results/par_bas_gs_$INIT.$N.txt

done

exit 0

