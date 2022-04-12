#!/bin/bash

#SBATCH --job-name=STAR_alignment_SCRI_ROOT_RNAs_2pass # Job name
#SBATCH --nodes=1
#SBATCH --ntasks=9
#SBATCH --time=120 # 
#SBATCH --mem=40000 # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --partition=production
#SBATCH --account=adandekar
#SBATCH --array=1-42
#SBATCH --output=slurmout/combined_genomes/STAR_alignment_SCRI_ROOT_RNAs_2pass_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=slurmout/combined_genomes/STAR_alignment_SCRI_ROOT_RNAs_2pass_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-type=ALL
#SBATCH --mail-user=hsaxe@ucdavis.edu

start=`date +%s`
echo $HOSTNAME
echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" samples.txt`

REF="References/star.overlap100.Jm3101_v1.0_Walnut_2.0_genomic"

outpath="05-STAR_alignment_2pass_combined_genomes"
[[ -d ${outpath} ]] || mkdir ${outpath}
[[ -d ${outpath}/${sample} ]] || mkdir ${outpath}/${sample}

echo "SAMPLE: ${sample}"

module load star

call="STAR
    --runThreadN 8 \
    --genomeDir $REF \
    --twopassMode Basic \
    --outSAMtype BAM SortedByCoordinate \
    --readFilesCommand zcat \
    --readFilesIn 01-HTS_Preproc/${sample}/${sample}_R1.fastq.gz 01-HTS_Preproc/${sample}/${sample}_R2.fastq.gz \
    --quantMode GeneCounts \
    --outFileNamePrefix ${outpath}/${sample}/${sample}_ \
    > ${outpath}/${sample}/${sample}-STAR.stdout 2> ${outpath}/${sample}/${sample}-STAR.stderr"

echo $call
eval $call

end=`date +%s`
runtime=$((end-start))
echo $runtime
