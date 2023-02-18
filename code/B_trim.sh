#!/bin/bash

# According to tutorial
## And then the FASTQ files were trimmed using the Trime Galore package and the command:
## trim_galore --fastqc --paired ERR1036032.nodup_R1.fastq.gz ERR1036032.nodup_R2.fastq.gz

#Interactive job on Carbonate
# srun -p interactive -N 1 --ntasks-per-node=1 --cpus-per-task=8 --time=07:59:00 --pty bash

  # # trim galore is available as a module on Carbonate
  # # requires loading dependencies
  # module load python
  # # Python programming language version 3.9.8 loaded.
  # module load fastqc
  # # Perl programming language version 5.30.1 loaded.
  # # fastqc version 0.11.9 loaded.
  # module load trimgalore
  # # trimgalore version 0.6.7 loaded.
# Setup -----------------------------------

#path to git directory
dir_repo="/N/slate/danschw/spore-gfp-seq"

out_dir="$dir_repo/data/trimmed"
mkdir -p $out_dir
cd $out_dir

### Vars in batch_trim.sh
# R1=$1
# R2=$2 

# files to process
READS=(GSF2865-delta6-ANC GSF2865-dSpoIIE-ANC GSF3121-delta6-GFP-col22 GSF3121-delta6-GFP-col55 GSF3121-delta6-GFP-col70 GSF3121-delta6-GFP-col72)
N=($(seq 0 5))

for i in ${N[@]}; do
sbatch --job-name="dedup_$i" --time=0:30:00 --cpus-per-task=4 \
"$dir_repo/code/batch_trim.sh" \
"$dir_repo/data/dedup/${READS[i]}_R1.fastq.gz" \
"$dir_repo/data/dedup/${READS[i]}_R2.fastq.gz"
done

