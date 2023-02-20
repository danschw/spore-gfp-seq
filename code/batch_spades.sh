#!/bin/bash
#SBATCH --mail-user=danschw@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --time=01:00:00
#SBATCH --mem=50gb
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --job-name=spades

##### setup #####


# SPAdes is available as a module on Carbonate
module load spades
# spades version 3.14.1 loaded.

#path to git directory
dir_repo="/N/slate/danschw/spore-gfp-seq"

out_dir="$dir_repo/data/mapping/assembly"
mkdir -p $out_dir
cd $out_dir

##### Assign vars #####
R1=$1
R2=$2 
PREFIX=$3

#### Assemble ####
spades.py -t 16 -m 50 -1 $R1 -2 $R2 \
-o "$out_dir/$PREFIX"

# copy assembled contigs file for MGEfinder
mkdir -p "$dir_repo/data/mapping/workdir/00.assembly"

cp "$out_dir/$PREFIX/contigs.fasta" \
"$dir_repo/data/mapping/workdir/00.assembly/$PREFIX.fna"
