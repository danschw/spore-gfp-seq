# spore-gfp-seq
Genome assembly and analysis of enineered bacterial strains

Following tutorial of MGEfinder using Illumina sequencing data of my strains.
https://github.com/bhattlab/MGEfinder/wiki/Tutorial

Executed on IU Carbonate.

A. FASTQ files were then deduplicated using the SuperDeduper command from the HTStream toolset.

B. FASTQ files were trimmed using the Trime Galore package

C. The reference genome was indexed for alignment with BWA MEM and the alignment was performed using BWA MEM.

D. To generate the assembled contig file, use SPAdes.


