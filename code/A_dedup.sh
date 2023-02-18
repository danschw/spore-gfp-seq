#!/bin/bash

# According to tutorial
## FASTQ files were then deduplicated using the SuperDeduper command from the HTStream toolset with the following command:
## hts_SuperDeduper -g -1 ERR1036032_1.fastq.gz -2 ERR1036032_2.fastq.gz -p ERR1036032.nodup

# "-g" option doesn't exist in HTStream_v1.3.0. This enable outputs in gzipped format. 
# That is now the default, which can be changed with "-u" for uncompressed output.https://github.com/s4hts/HTStream/releases/download/v1.3.0-release/HTStream_v1.3.0-release.tar.gz

# Setup -----------------------------------

#path to git directory
dir_repo="/N/slate/danschw/spore-gfp-seq"
cd $dir_repo

# install HTStream, including SuperDeduper
## https://s4hts.github.io/HTStream/
tools="$dir_repo/code/tools"
mkdir -p $tools
cd $tools

wget https://github.com/s4hts/HTStream/releases/download/v1.3.0-release/HTStream_v1.3.0-release.tar.gz
tar -xvf HTStream_v1.3.0-release.tar.gz hts_SuperDeduper
rm HTStream_v1.3.0-release.tar.gz 

# run jobs on Carbonate

### Vars in batch_dedup.sh
# PREFIX=$1
# R1=$2
# R2=$3 

# files to process
READS=(GSF2865-delta6-ANC-ANC-pl_S1 GSF2865-dSpoIIE-ANC-ANC-pl_S2 GSF3121-delta6-GFP-col22_S61 GSF3121-delta6-GFP-col55_S62 GSF3121-delta6-GFP-col70_S63 GSF3121-delta6-GFP-col72_S64)
PREFIX=(GSF2865-delta6-ANC GSF2865-dSpoIIE-ANC GSF3121-delta6-GFP-col22 GSF3121-delta6-GFP-col55 GSF3121-delta6-GFP-col70 GSF3121-delta6-GFP-col72)
N=($(seq 0 5))

for i in ${N[@]}; do
sbatch --job-name="dedup_$i" --time=0:30:00 --cpus-per-task=4 \
"$dir_repo/code/batch_dedup.sh" \
"$dir_repo/data/dedup/${PREFIX[i]}" \
"$dir_repo/data/input/sequencing_reads/${READS[i]}_R1_001.fastq.gz" \
"$dir_repo/data/input/sequencing_reads/${READS[i]}_R2_001.fastq.gz"
done

