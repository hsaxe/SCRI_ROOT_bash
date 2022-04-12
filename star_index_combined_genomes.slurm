#!/bin/bash

#SBATCH --job-name=star_index_SCRI_ROOT_RNAs # Job name
#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH --time=200 # 200 minutes. Only used 00:10:31
#SBATCH --mem=40000 # (40 GB) Memory pool for all cores (see also --mem-per-cpu). Only used 12.62 GB
#SBATCH --partition=production
#SBATCH --account=adandekar
#SBATCH --output=slurmout/combined_genomes/star-index_%A.out # File to which STDOUT will be written
#SBATCH --error=slurmout/combined_genomes/star-index_%A.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user=hsaxe@ucdavis.edu

start=`date +%T`
echo $start

startS=`date +%s`

echo $HOSTNAME

outpath="References"

mkdir -p ${outpath}

cd ${outpath}

wd="star.overlap100.Jm3101_v1.0_Walnut_2.0_genomic"

mkdir -p ${wd}

cd ${wd}

GENOME="../Jm3101_v1.0_Walnut_2.0_genomic.fna"

GTF="../Jm3101_v1.0_Walnut_2.0_genomic.gtf"

module load star

call="STAR
--runThreadN 8 \
--runMode genomeGenerate \
--genomeDir . \
--genomeFastaFiles ${GENOME} \
--sjdbGTFfile ${GTF} \
--sjdbOverhang 100 \
--genomeSAindexNbases 13"

echo $call
eval $call

end=`date +%T`
echo $end

endS=`date +%s`

runtime=$((endS-startS))
echo $runtime