---
layout: post
title: Sun. Sep. 4, 2022
subtitle: Berdahl-sockeye-salmon analysis - Part 1
project: Berdahl-sockeye-salmon
tags: Berdahl-sockeye-salmon
comments: true
---

### Background
1. 30 sockeye salmon sampled; 1-15: territorial, 16-30: social
2. brain, liver, and gonad saved in RNAlater - frozen at -80C
3. RNA extracted - see github issues: [1](https://github.com/RobertsLab/resources/issues/1307) and [2](https://github.com/RobertsLab/resources/issues/1410)
4. RNA submitted to UT Austin GSAF on 5/24 for Tag-seq. Received gonad samples on 7/25. See [github issue](https://github.com/RobertsLab/resources/issues/1501).
5. Gave go ahead to GSAF to complete rest of tagseq on 8/12.

## Tag-seq analysis - Gonad Samples

I received [Tag-seq](https://dnatech.genomecenter.ucdavis.edu/tag-seq-gene-expression-profiling/) results from GSAF. Raw sequences were processed using the this [R script](https://github.com/mattgeorgephd/Berdahl-sockeye-salmon/blob/2d11b440bdbbf1a4dbf2da5cb30e66d45890ce7e/tag-seq/code/1_process-tagseq-data-salmon.Rmd).

Raw sequences were downloaded from Gannet:
```
# Download tag-seq data
wget -r \
--no-directories --no-parent \
-P . \
-A .fastq.gz https://gannet.fish.washington.edu/panopea/berdahl-sockeye-salmon/20220714-tagseq-gonad/ \
--no-check-certificate
```

Fastqc was run [before](https://gannet.fish.washington.edu/panopea/berdahl-sockeye-salmon/multiqc_report.html) and [after](https://gannet.fish.washington.edu/panopea/berdahl-sockeye-salmon/multiqc_report_trimmed.html) trimming (hard trim first 15 bps):

```bash
# trim adapter sequences
mkdir trim-fastq/
cd /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/raw-data/
for F in *.fastq
do
#strip .fastq and directory structure from each file, then
# add suffice .trim to create output name for each file
results_file="$(basename -a $F)"
# -u 15 : hard trim first 15 bp
# -m 20 : minimum length cutoff
# run cutadapt on each file
/home/shared/8TB_HDD_02/mattgeorgephd/.local/bin/cutadapt $F -a A{8} -a G{8} -a AGATCGG -u 15 -m 20 -o \
/home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/trim-fastq/$results_file
done
```
and concatenating by sequencing lane:

```bash
# concatenate fastq files by lane
mkdir merged-fastq
cd trim-fastq/
printf '%s\n' *.fastq | sed 's/^\([^_]*_[^_]*\).*/\1/' | uniq |
while read prefix; do
    cat "$prefix"*R1*.fastq >"${prefix}_R1.fastq"
    # cat "$prefix"*R2*.fastq >"${prefix}_R2.fastq" # include if more than one run
done
# I moved files to merged-fastq
```
Sequences were aligned to the [O. nerka genome](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_006149115.2/) using hisat2 (a splice aware aligner):

```bash
# create hisat2 index for cgigas genome (took 31 min on Raven)
/home/shared/hisat2-2.2.1/hisat2-build \
-f /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/sequences/GCF_006149115.2_Oner_1.1_genomic.fna /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/sequences/hisat2_genome_index.fa # called the reference genome (scaffolds)
```

```bash
# Run hisat2 on trimmed reads
mkdir hisat2_sam/
mkdir hisat2_bam/
cd /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/merged-fastq/
# This script exports alignments as bam files
# sorts the bam file because Stringtie takes a sorted file for input (--dta)
# removes the sam file because it is no longer needed
array=($(ls *.fastq)) # call the sequences - make an array to align
for i in ${array[@]}; do
       sample_name=`echo $i| awk -F [.] '{print $1}'`
	/home/shared/hisat2-2.2.1/hisat2 \
	  -p 16 \
	  --dta \
	  -x /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/sequences/hisat2_genome_index.fa \
	  -U ${i} \
	  -S /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/hisat2_sam/${sample_name}.sam

	  /home/shared/samtools-1.12/samtools sort -@ 8 -o                /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/hisat2_bam/${sample_name}.bam /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/hisat2_sam/${sample_name}.sam
    		echo "${i} bam-ified!"
        # rm ${sample_name}.sam
done >> hisat2out.txt 2>&1
```
The average alignment rate was 88.656 +/- 2.21 sd (after trim/filter).

Next, I downloaded the genome features from ncbi (stored on gannet)

```bash
# Download sequences from gannet
cd sequences/
wget -r \
--no-directories --no-parent \
-P . \
-A GCF_006149115.2_Oner_1.1_genomic.gff https://gannet.fish.washington.edu/panopea/berdahl-sockeye-salmon/genome/ \
--no-check-certificate
wget -r \
--no-directories --no-parent \
-P . \
-A GCF_006149115.2_Oner_1.1_genomic.fna https://gannet.fish.washington.edu/panopea/berdahl-sockeye-salmon/genome/ \
--no-check-certificate
```
and generated a mRNA genome feature track file (.gff) using the following code:

```bash
# Generate mRNA feature track from genomic_sequence
head sequences/GCF_006149115.2_Oner_1.1_genomic.gff
grep -e "Gnomon	mRNA" -e "RefSeq	mRNA" -e "cmsearch	mRNA" -e "tRNAscan-SE	mRNA" \
sequences/GCF_006149115.2_Oner_1.1_genomic.gff \
| /home/shared/bedtools2/bin/sortBed \
-faidx sequences/GCF_006149115.2_Oner_1.1_genomic-sequence-lengths.txt \
> sequences/GCF_006149115.2_Oner_1.1_mRNA.gff
head sequences/GCF_006149115.2_Oner_1.1_mRNA.gff
```
I then used StringTie2 to assmble the hist2 alignments using the mRNA feature track I just generated:

```bash
# Assemble hisat2 alignments w/ stringtie2 using mRNA genome feature track
array=($(ls /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/hisat2_bam/*.bam))
for i in ${array[@]}; do
        sample_name=`echo $i| awk -F [.] '{print $1}'`
	      /home/shared/stringtie-2.2.1.Linux_x86_64/stringtie \
	      -p 48 \
	      -e \
	      -B \
	      -G /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/sequences/GCF_006149115.2_Oner_1.1_mRNA.gff \
	      -A ${sample_name}.gene_abund.tab \
	      -o ${sample_name}.gtf ${i} \
        echo "StringTie assembly for seq file ${i}" $(date)
done
echo "StringTie assembly COMPLETE, starting assembly analysis" $(date)
# 20220607 - I could not figure out how to designate the output. All outputs ended up in bowtie output folder.
```
The resulting bam files were then merged and compiled to generate the gene count matrix. The Gene count matrix was then used an in input to DESEQ2 analysis.

```bash
cd /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/hisat2_bam
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
	-G /home/shared/8TB_HDD_02/mattgeorgephd/berdahl-sockeye-salmon/sequences/GCF_006149115.2_Oner_1.1_mRNA.gff \
	-o onerka_merged.gtf gtf_list.txt #Merge GTFs to form $
echo "Stringtie merge complete" $(date)
# Compute accuracy of gff
# gffcompare -r ../../../refs/Panopea-generosa-v1.0.a4.mRNA_SJG.gff3 -G -o merged Pgenerosa_merged.gtf #Compute the accuracy and pre$
# echo "GFFcompare complete, Starting gene count matrix assembly..." $(date)
# Compile gene count matrix from GTFs
/home/shared/stringtie-2.2.1.Linux_x86_64/prepDE.py \
  -g onerka_gene_count_matrix.csv \
  -i listGTF.txt #Compile the gene count matrix
echo "Gene count matrix compiled." $(date)
```
