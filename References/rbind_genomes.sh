#!/bin/bash

# Row bind genome files together with cat
cat GCF_004785595.1_Jm3101_v1.0_genomic.fna GCF_001411555.2_Walnut_2.0_genomic.fna > Jm3101_v1.0_Walnut_2.0_genomic.fna

# Row bind .gtf files together with cat, head, and tail

# Get .gtfs minus the first four lines (header)
tail -n +5 GCF_004785595.1_Jm3101_v1.0_genomic.gtf > Jm_GTF.tmp

tail -n +5 GCF_001411555.2_Walnut_2.0_genomic.gtf > Jr_GTF.tmp

# Row bind the files together
cat Jm_GTF.tmp Jr_GTF.tmp > Jm3101_v1.0_Walnut_2.0_genomic.gtf



