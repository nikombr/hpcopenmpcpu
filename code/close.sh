#!/bin/bash
#BSUB -J close # name
#BSUB -o outfiles/close_%J.out # output file
#BSUB -q hpcintro 
#BSUB -n 24 ## cores (24 is maximum)
#BSUB -R "rusage[mem=1GB]" 
#BSUB -W 60 # useable time in minutes
##BSUB -N # send mail when done
#BSUB -R "span[hosts=1]"

N=55 ## 55, 165, 275, 385
ITER=200000 ## 200000, 8000, 1500, 600
TOLERANCE=-1
START_T=5

lscpu

rm -rf results/parallel_j_close_$N.txt
rm -rf results/parallel_gs_close_$N.txt

for threads in {1..24..1};
do  
    echo -n $threads " " >> results/parallel_j_close_$N.txt
    echo -n $threads " " >> results/parallel_gs_close_$N.txt
    OMP_NUM_THREADS=$threads OMP_SCHEDULE=static OMP_PROC_BIND=close OMP_PLACES=cores ./parallel_j $N $ITER $TOLERANCE $START_T >> results/parallel_j_close_$N.txt
    OMP_NUM_THREADS=$threads OMP_SCHEDULE=static,1 OMP_PROC_BIND=close OMP_PLACES=cores ./parallel_gs $N $ITER $TOLERANCE $START_T >> results/parallel_gs_close_$N.txt

done

exit 0

