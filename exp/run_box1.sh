#! /bin/sh

rm STDIN.*
dir=$(pwd)

qsub << EOF
#!/bin/csh
#
## LSF batch script to run an MPI application
#
#BSUB -N myjob                 # job name
#BSUB -o myjob.%J.out          # output file name in which %J is replaced by the job ID
#BSUB -e myjob.%J.err          # error file name in which %J is replaced by the job ID
#BSUB -q batch                 # queue
#PBS -l procs=8
#PBS -l walltime=00:10:00
#PBS -A esmf
#PBS -d .

module load intel mpt
module list

echo ""
echo "Modules intel mpt loaded"
echo "PATH: $PATH"
echo "LD_LIBRARY_PATY: $LD_LIBRARY_PATH"
echo ""

#run the executable
cd $dir
./MOM_run.csh --platform zeus --type MOM_solo --experiment box1 --npes 8 --download_input_data

EOF
