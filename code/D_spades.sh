#!/bin/bash

# According to tutorial
  # Finally, to generate the assembled contig file ERR1036032.fna, you can use the SPAdes command:
  # spades.py -1 ERR1036032.nodup_R1_val_1.fq.gz -2 ERR1036032.nodup_R2_val_2.fq.gz -o ERR1036032
  # The assembled contigs are available in the ERR1036032/contigs.fasta file

# Setup -----------------------------------

#path to git directory
dir_repo="/N/slate/danschw/spore-gfp-seq"

out_dir="$dir_repo/data/mapping"
mkdir -p $out_dir
cd $out_dir




# assembly ---------------------------------------
# SPAdes is available as a module on Carbonate
  # module load spades
  # spades version 3.14.1 loaded.
  
### Vars in batch_spade.sh
# R1=$1
# R2=$2
#PREFIX=$3

# files to process
READS=(GSF2865-delta6-ANC GSF2865-dSpoIIE-ANC GSF3121-delta6-GFP-col22 GSF3121-delta6-GFP-col55 GSF3121-delta6-GFP-col70 GSF3121-delta6-GFP-col72)
N=($(seq 0 5))


for i in ${N[@]}; do 
sbatch --job-name="spades_$i" \
"$dir_repo/code/batch_spades.sh" \
"$dir_repo/data/trimmed/${READS[i]}_R1_val_1.fq.gz"  \
"$dir_repo/data/trimmed/${READS[i]}_R2_val_2.fq.gz" \
${READS[i]} 
done

