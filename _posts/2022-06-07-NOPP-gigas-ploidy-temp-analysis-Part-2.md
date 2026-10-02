---
layout: post
title: Tue. Jun. 7, 2022
subtitle: NOPP-gigas-ploidy-temp analysis - Part 2
project: NOPP-gigas-ploidy-temp
tags: NOPP-gigas-ploidy-temp
comments: true
---

### Background
We received 3'end RNA sequencing (3'Tag RNA-Seq or TagSeq) data from 72 samples *crassostrea gigas* samples from the UT-Austin [Genomic Sequencing and Analysis Facility (GSAF)](https://wikis.utexas.edu/display/GSAF/Home+Page).

The tagseq sample list with sample IDs and treatments is available [here](https://docs.google.com/spreadsheets/d/1KY6P25HEmrDeszph56OY7tI1vAOd2rXxQ8wfZtCM7g0/edit#gid=0). See the prior post for QC information and location of files on gannet.

### Tagseq data processing

The tagseq data was received as zipped fastq.gz files, so the first thing to download them from gannet using **wget**:

```bash
# Download tag-seq data
mkdir raw-data/
cd raw-data/

wget -r -A .fastq.gz https://gannet.fish.washington.edu/panopea/NOPP-gigas-ploidy-temp/20220203-tagseq/ \
--no-check-certificate
```
and unzip them using **gunzip**:

```bash
# unzip .fastq.gz files
cd raw-data/
gunzip *.fastq.gz

```
The sequencing facility provided the data as the result of two sequencing lanes per sample ID. The next step was to combine them:

```bash
# concatenate fastq files by lane

cd raw-data/

printf '%s\n' *.fastq | sed 's/^\([^_]*_[^_]*\).*/\1/' | uniq |
while read prefix; do
    cat "$prefix"*R1*.fastq >"${prefix}_R1.fastq"
    # cat "$prefix"*R2*.fastq >"${prefix}_R2.fastq" # include if more than one run
done

# I moved files to merged-fastq
```
### Trimming and Filtering

Then trim the adapter sequences used in tagseq using [cutadapt](https://cutadapt.readthedocs.io/en/stable/). These include poly a and g tails, as well as AGATCGG. The first 15 basepairs of the 3' end were trimmed to prevent the inclusion of low quality reads (-q, quality-cutoff). After this process, any fragments that were less than 20 basepairs (-m, minimum read length).

```bash
# trim adapter sequences

mkdir trim-fastq/
cd merged-fastq

for F in *.fastq
do
#strip .fastq and directory structure from each file, then
# add suffice .trim to create output name for each file
results_file="$(basename -a $F)"

# run cutadapt on each file
/home/shared/8TB_HDD_02/mattgeorgephd/.local/bin/cutadapt $F -a A{8} -a G{8} -a AGATCGG -q 15 -m 20 -o \
/home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/trim-fastq/$results_file
done

```

Trimming and filtering resulted in an ~7% loss in reads.

#### Alignment

After trimming I aligned the reads to the **C gigas** Roslin genome using [bowtie2](https://bowtie-bio.sourceforge.net/bowtie2/manual.shtml). The first step was to create the bowtie2 index for the Rosline genome (.fa file, previously downloaded from gannet) with mitochondrial DNA included.

```bash
# create bowtie2 index for cgigas genome (took 8 min on Raven)

/home/shared/bowtie2-2.4.4-linux-x86_64/bowtie2-build \
/home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/sequences/cgigas_uk_roslin_v1_genomic-mito.fa \
/home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/sequences/cgigas_roslin_v1.fa

```
and then run bowtie on the trimmed reads

```bash
# Run bowtie on trimmed reads, pre-set option= --sensitive-local

mkdir bowtie_sam/
cd bowtie_sam/

for file in /home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/trim-fastq/*.fastq
do
results_file="$(basename -a $file).sam"

# run Bowtie2 on each file
/home/shared/bowtie2-2.4.4-linux-x86_64/bowtie2 \
--local \
-x /home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/sequences/cgigas_roslin_v1.fa \
--sensitive-local \
--threads 48 \
--no-unal \
-k 5 \
-U $file \
-S $results_file; \
done >> bowtieout.txt 2>&1

```
I then checked the alignment rate:

```bash
# check % alignment from Bowtie

grep "overall alignment rate" /home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/bowtie_sam/bowtieout.txt

# average alignment rate = 87.8% +/- 1.3

```

The resulting .sam files were then converted to .bam files:

```bash
# Convert .sam files to .bam files, create bam indices

mkdir bowtie_bam/
cd bowtie_bam/

for file in /home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/bowtie_sam/*.sam
do
results_file="$(basename -a $file)_sorted.bam"
/home/shared/samtools-1.12/samtools view -b $file | /home/shared/samtools-1.12/samtools sort -o /home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/bowtie_bam/$results_file
done

```

#### Assembly

After alignment, assembly and preparation for DESeq2 analysis was performed using [StringTie](https://ccb.jhu.edu/software/stringtie/) using the mRNA feature track of the Rosline **C gigas** genome.

```bash
# Assemble bowtie alignments w/ stringtie2 using mRNA genome feature track
array=($(ls /home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/bowtie_bam/*.bam))

for i in ${array[@]}; do
        sample_name=`echo $i| awk -F [.] '{print $1}'`
	      /home/shared/stringtie-2.2.1.Linux_x86_64/stringtie \
	      -p 48 \
	      -e \
	      -B \
	      -G /home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/sequences/cgigas_uk_roslin_v1_mRNA.gff \
	      -A ${sample_name}.gene_abund.tab \
	      -o ${sample_name}.gtf ${i} \

        echo "StringTie assembly for seq file ${i}" $(date)
done

echo "StringTie assembly COMPLETE, starting assembly analysis" $(date)

# 20220607 - I could not figure out how to designate the output. All outputs ended up in bowtie output folder.

```

Next I merged the stringtie output and generated the gene count matrix to prepare for DESeq2 analysis.

```bash
cd /home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/bowtie_bam

# make gtf list file (needed for stringtie merge function)
for filename in *.gtf; do
  echo $PWD/$filename;
  done > gtf_list.txt

# make listGTF file (needed for count matrix), two columns w/ sample ID
for filename in *.gtf; do
  echo $filename $PWD/$filename;
  done > listGTF.txt

# merge GTFs into a single file
/home/shared/stringtie-2.2.1.Linux_x86_64/stringtie \
  --merge \
  -p 48 \
	-G /home/shared/8TB_HDD_02/mattgeorgephd/gigas-WGBS-ploidy-desiccation/sequences/cgigas_uk_roslin_v1_mRNA.gff \
	-o cgigas_merged.gtf gtf_list.txt #Merge GTFs to form $

echo "Stringtie merge complete" $(date)

# Compile gene count matrix from GTFs
/home/shared/stringtie-2.2.1.Linux_x86_64/prepDE.py \
  -g cgigas_gene_count_matrix.csv \
  -i listGTF.txt #Compile the gene count matrix

echo "Gene count matrix compiled." $(date)

```
