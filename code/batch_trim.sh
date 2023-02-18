#!/bin/bash
#SBATCH --mail-user=danschw@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=4
#SBATCH --time=0:30:00
#SBATCH --mem=1gb
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --job-name=trim

##### setup #####


# trim galore is available as a module on Carbonate
# requires loading dependencies
module load python
module load fastqc
module load trimgalore

#path to git directory
dir_repo="/N/slate/danschw/spore-gfp-seq"

out_dir="$dir_repo/data/trimmed"
mkdir -p $out_dir
cd $out_dir

##### Assign vars #####
R1=$1
R2=$2 


##### run hts_SuperDeduper #####

trim_galore --fastqc -j 4 --paired  $R1 $R2
