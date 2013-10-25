#! /bin/sh

rm STDIN.*
rm -rf ../work/box1/RESTART/                                         
rm -rf ../work/box1/input.nml
cp ../work/box1/INPUT/ocean_hgrid.nc ../work/box1  
cp ../work/box1/INPUT/grid_spec.nc ../work/box1  

qsub << EOF
#!/bin/csh
#
## LSF batch script to run an MPI application
#
#BSUB -N myjob                 # job name
#BSUB -o myjob.%J.out          # output file name in which %J is replaced by the job ID
#BSUB -e myjob.%J.err          # error file name in which %J is replaced by the job ID
#BSUB -q batch                 # queue
#PBS -l procs=24
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
cd /home/Fei.Liu/github/mom/exp
./MOM_run.csh --platform zeus --type MOM_solo --experiment box1 --npes 24 --download_input_data

EOF
