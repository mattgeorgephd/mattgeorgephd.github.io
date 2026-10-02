---
layout: post
title: Mon. Apr. 11, 2022
subtitle: PSMFC-mytilus-byssus-pilot Analysis Part 1
project: PSMFC-mytilus-byssus-pilot
tags: PSMFC-mytilus-byssus-pilot
comments: true
---

------------------------------------------------------------------------------------------------------
# Download and QC [tag-seq](https://gannet.fish.washington.edu/panopea/PSMFC-mytilus-byssus-pilot/20220405-tagseq/) data received on 7/14/2022

All following code chunks were run on Raven

### Download tag-seq data
```{bash}
mkdir raw-data/
cd raw-data/

wget -r \
--no-directories --no-parent \
-P . \
-A .fastq.gz https://gannet.fish.washington.edu/panopea/PSMFC-mytilus-byssus-pilot/20220405-tagseq/ \
--no-check-certificate

```
### unzip .fastq.gz files
```{bash}
cd raw-data/
gunzip *.fastq.gz

```
### Run fastqc on untrimmed files
```{bash}
mkdir fastqc/
mkdir fastqc/untrimmed/

/home/shared/FastQC/fastqc \
/home/shared/8TB_HDD_02/mattgeorgephd/PSMFC-mytilus-byssus-pilot/raw-data/*.fastq \
--outdir /home/shared/8TB_HDD_02/mattgeorgephd/PSMFC-mytilus-byssus-pilot/fastqc/untrimmed/ \
--quiet
```

### Run multiqc
```{bash}

eval "$(/opt/anaconda/anaconda3/bin/conda shell.bash hook)"
conda activate

cd fastqc/untrimmed/

multiqc .

```
Link to [multiQC report](https://gsafjobs.icmb.utexas.edu/qc/JA22078/SA22060/multiqc/multiqc_report.html) untrimmed sequences

### trim adapter sequences
```{bash}
mkdir trim-fastq/
cd raw-data

for F in *.fastq
do
#strip .fastq and directory structure from each file, then
# add suffice .trim to create output name for each file
results_file="$(basename -a $F)"

# run cutadapt on each file
/home/shared/8TB_HDD_02/mattgeorgephd/.local/bin/cutadapt $F -a A{8} -a G{8} -a AGATCGG -u 15 -m 20 -o \
/home/shared/8TB_HDD_02/mattgeorgephd/PSMFC-mytilus-byssus-pilot/trim-fastq/$results_file
done

```
### Run fastqc on trimmed files
```{bash}
mkdir fastqc/
mkdir fastqc/trimmed/

/home/shared/FastQC/fastqc \
/home/shared/8TB_HDD_02/mattgeorgephd/PSMFC-mytilus-byssus-pilot/merged-fastq/*.fastq \
--outdir /home/shared/8TB_HDD_02/mattgeorgephd/PSMFC-mytilus-byssus-pilot/fastqc/trimmed/ \
--quiet

```
### Run multiqc on trimmed files
```{bash}

eval "$(/opt/anaconda/anaconda3/bin/conda shell.bash hook)"
conda activate

cd fastqc/trimmed/

multiqc .

```
### concatenate fastq files by lane
```{bash}
mkdir merged-fastq
cd trim-fastq/

printf '%s\n' *.fastq | sed 's/^\([^_]*_[^_]*\).*/\1/' | uniq |
while read prefix; do
    cat "$prefix"*R1*.fastq >"${prefix}_R1.fastq"
    # cat "$prefix"*R2*.fastq >"${prefix}_R2.fastq" # include if more than one run
done

# I moved files to merged-fastq
```
Link to [multiQC report](https://gannet.fish.washington.edu/panopea/PSMFC-mytilus-byssus-pilot/multiqc_report_trimmed_merged.html) on trimmed and concatenated sequences

-----------------------

# Generate de novo transcriptome from available RNA-seq datasets

### [RAVEN] Download mytilus trossulus transcriptome - https://www.ncbi.nlm.nih.gov/sra/SRX3198554
### Tutorial: https://blogs.iu.edu/ncgas/2021/02/22/a-beginners-guide-to-the-sra/
```{bash}
# /home/shared/sratoolkit.2.11.2-ubuntu64/bin/vdb-config --interactive

mkdir SRA/
cd SRA/

# Download SRA accession list - all 47 mytilus trossulus
wget -r \
--no-directories --no-parent \
-P . \
-A SraAccList.txt https://gannet.fish.washington.edu/panopea/PSMFC-mytilus-byssus-pilot/genome/ \
--no-check-certificate

# Download SRA files using SRA accession list
/home/shared/sratoolkit.2.11.2-ubuntu64/bin/prefetch \
--option-file SraAccList.txt

# Move .sra files out of containing folders to SRA
mv */* .

# convert files to fastq
for file in *.sra; do /home/shared/sratoolkit.2.11.2-ubuntu64/bin/fasterq-dump "${file}"; done # e -48

```
# Transfer SRA files to Gannet
```
rsync --archive --progress --verbose --relative ./SRA mngeorge@gannet.fish.washington.edu:/volume2/web/panopea/PSMFC-mytilus-byssus-pilot
```

# Running Trinity on Mox

### Login to mox
```
ssh mngeorge@mox.hyak.uw.edu
```

### Login to Gannet and copy fastq files to gscratch
```
ssh mngeorge@gannet.fish.washington.edu <login>
cd /volume2/web/panopea/PSMFC-mytilus-byssus-pilot/
rsync --archive --progress --verbose --relative ./20220405-tagseq mngeorge@mox.hyak.uw.edu:/gscratch/srlab/mngeorge/data/mtrossulus

rsync --archive --progress --verbose --relative ./SRA mngeorge@mox.hyak.uw.edu:/gscratch/srlab/mngeorge/data/mtrossulus

#the serve was disconnected half way through, so I ran this:

rsync --archive --progress --verbose --relative --ignore-existing --dry-run ./sbatch_scripts mngeorge@mox.hyak.uw.edu:/gscratch/srlab/mngeorge/sbatch_scripts

```

### Add paths to ~/.bashrc file
```

# Open bashrc w/ nano
nano ~/.bashrc

# Check inclusion
echo "$PATH//:/$'\n'}"

```

### Add job to queue
```
# Added 9/16/2022 - data on scrubbed for only 21 days
cd /gscratch/scrubbed/mngeorge/sbatch_scripts
sbatch 202208_PSMFC-mytilus-byssus-pilot_trinity.sh
```
### Check Job Status
```
scontrol show job 3897217
```
or

```
squeue
```
