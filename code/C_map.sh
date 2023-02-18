#!/bin/bash

# According to tutorial
# The reference genome was indexed for alignment with BWA MEM and the alignment was performed using the commands:
#   bwa index efae_GCF_900639545.fna
#   bwa mem efae_GCF_900639545.fna ERR1036032.nodup_R1_val_1.fq.gz ERR1036032.nodup_R2_val_2.fq.gz > ERR1036032.efae_GCF_900639545.sam
# YOU MUST USE BWA FOR YOUR ALIGNMENTS. We have found that bowtie2 is not compatible with this analysis.


#Interactive job on Carbonate
srun -p interactive -N 1 --ntasks-per-node=1 --cpus-per-task=8 --time=07:59:00 --pty bash

# # BWA mem is available as a module on Carbonate
module load bwa-mem2
# bwa-mem2 version 2.0pre2 loaded


# Setup -----------------------------------

#path to git directory
dir_repo="/N/slate/danschw/spore-gfp-seq"

out_dir="$dir_repo/data/mapping"
mkdir -p $out_dir
cd $out_dir


# I will already start to organize files in folder dtructure for MGEfinder
mkdir -p "$out_dir/workdir/00.assembly"
mkdir -p "$out_dir/workdir/00.bam"
mkdir -p "$out_dir/workdir/00.genome"

# download reference genome -----------------------
# B. sutilis 168 delta6 (/GCF_001660525.1)
wget -P workdir/00.genome \
https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/001/660/525/GCF_001660525.1_ASM166052v1/GCF_001660525.1_ASM166052v1_genomic.fna.gz
gunzip workdir/00.genome/GCF_001660525.1_ASM166052v1_genomic.fna.gz
genome="GCF_001660525.1_ASM166052v1_genomic.fna"

# index ---------------------------------------
bwa-mem2 index "$out_dir/workdir/00.genome/$genome"


# mapping ---------------------------------------
mkdir -p "$out_dir/bwa_sam"
# files to process
READS=(GSF2865-delta6-ANC GSF2865-dSpoIIE-ANC GSF3121-delta6-GFP-col22 GSF3121-delta6-GFP-col55 GSF3121-delta6-GFP-col70 GSF3121-delta6-GFP-col72)
N=($(seq 0 5))

# runs quickly... so no sbatch
for i in ${N[@]}; do
bwa-mem2 mem -t 8 \
"$out_dir/workdir/00.genome/$genome" \
"$dir_repo/data/trimmed/${READS[i]}_R1_val_1.fq.gz" \
"$dir_repo/data/trimmed/${READS[i]}_R2_val_2.fq.gz" \
> "$out_dir/bwa_sam/${READS[i]}_$genome.sam"
done




spades.py -1 ERR1036032.nodup_R1_val_1.fq.gz -2 ERR1036032.nodup_R2_val_2.fq.gz -o ERR1036032