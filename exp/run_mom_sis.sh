#! /bin/sh

rm STDIN.*

qsub << EOF
#!/bin/csh
#
## LSF batch script to run an MPI application
#
#BSUB -N myjob                 # job name
#BSUB -o myjob.%J.out          # output file name in which %J is replaced by the job ID
#BSUB -e myjob.%J.err          # error file name in which %J is replaced by the job ID
#BSUB -q batch                 # queue
#PBS -l procs=32
#PBS -l walltime=00:20:00
#PBS -A esmf
#PBS -d .

module load intel mpt netcdf/4.2-intel-12.0.4.191-mpt-2.05 hdf4 hdf5/1.8.9-intel-12.0.4.191-mpt-2.05
module list

echo ""
echo "Modules intel mpt loaded"
echo "PATH: $PATH"
echo "LD_LIBRARY_PATY: $LD_LIBRARY_PATH"
echo ""

setenv wd /home/Fei.Liu/github/mom

#build the executable
#cd $wd/exp
#./MOM_compile.csh --platform zeus --type MOM_SIS --experiment MOM_SIS_BLING

#run the executable
#cd $wd/exp
#./MOM_run.csh --platform zeus --type MOM_SIS --experiment MOM_SIS_BLING --npes 32
cd $wd/work/MOM_SIS
/apps/mpt/2.05/bin/mpiexec_mpt -np 32 $wd/exec/zeus/MOM_SIS/fms_MOM_SIS.x > fms.out

EOF
