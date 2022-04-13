#! /bin/bash

# Make directory for raw data
mkdir -p 00-RawData

cd 00-RawData

# Link over raw data
ln -s /share/dandekarlab/SCRI-Project_Root_RNA_Seq/* .

# Make directory for each sample and move first read into it
for i in *_R1.fastq.gz; do 
    mkdir "${i%_R1.fastq.gz}" && mv $i "${i%_R1.fastq.gz}"
    done

# Move second reads into their respective directories
for i in *_R2.fastq.gz; do 
    mv $i "${i%_R2.fastq.gz}"
    done

# Make samples.txt for preprocessing with slurm
cd ..

ls 00-RawData/ | grep -v "FASTQC" > samples.txt