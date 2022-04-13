#! /bin/bash

# Make counts table from alignment

# Make directory for counts then loop through samples to extract the 4th field (library must have been reverse stranded) and everything but the first four rows.

mkdir 05-Counts 

mkdir 05-Counts/tmp

for sample in `cat samples.txt`; do \
    echo ${sample}
    cat 05-STAR_alignment_2pass_combined_genomes/${sample}/${sample}_ReadsPerGene.out.tab | tail -n +5 | cut -f4 > 05-Counts/tmp/${sample}.count 
done

# Get gene ids. Since they are all in the same order, any sample will do.
tail -n +5 05-STAR_alignment_2pass_combined_genomes/29JM-11-1/29JM-11-1_ReadsPerGene.out.tab | cut -f1 > 05-Counts/tmp/geneids.txt

# Paste all files together
paste 05-Counts/tmp/geneids.txt 05-Counts/tmp/*.count > 05-Counts/tmp/tmp.out

# Make colnames(including GeneID), didn't sort(so check order of output), then transpose and rbind with tmp counts table
cat <(echo "$(echo "GeneID" | cat - samples.txt)" | paste -s) 05-Counts/tmp/tmp.out > 05-Counts/SCRI_ROOT_RNAseq_counts_combined_genomes.txt
