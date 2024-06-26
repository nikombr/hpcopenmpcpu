#!/bin/bash
#BSUB -J experiment # name
#BSUB -o outfiles/experiment_%J.out # output file
#BSUB -q hpcintro 
#BSUB -n 24 ## cores (24 is maximum)
#BSUB -R "rusage[mem=1GB]" 
#BSUB -W 60 # useable time in minutes
##BSUB -N # send mail when done
#BSUB -R "span[hosts=1]"

rm -rf results/sequential_j.txt
rm -rf results/sequential_gs.txt

for N in {25..185..7};
do  
    ./sequential_j $N 100000 1e-8 20 >> results/sequential_j.txt
    ./sequential_gs $N 100000 1e-8 20 >> results/sequential_gs.txt

done

exit 0

