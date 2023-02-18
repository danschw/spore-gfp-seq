#!/bin/bash
#SBATCH --mail-user=danschw@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=0:30:00
#SBATCH --mem=1gb
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --job-name=dedup

##### setup #####
dir_repo="/N/slate/danschw/spore-gfp-seq"
tools="$dir_repo/code/tools"
cd $tools


out_dir="$dir_repo/data/dedup"
mkdir -p $out_dir

##### Assign vars #####
PREFIX=$1
R1=$2
R2=$3 


##### run hts_SuperDeduper #####

./hts_SuperDeduper -f $PREFIX -L "$PREFIX.log" -1 $R1 -2 $R2 

